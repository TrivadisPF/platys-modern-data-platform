import os
import re

import click
import docker
import tempfile
import tarfile
import logging
import ruamel.yaml
from pathlib import Path
import sys

__version__ = '2.0.0'
CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])


class PushRootLeft:
    def __init__(self, positions=42):
        self.positions = positions

    def __call__(self, s):
        result = []
        for line in s.splitlines(True):
            sline = line.strip()
            if not sline or sline[0] == '#':
                result.append(line)
            else:
                result.append(' ' * self.positions + line)
        return ''.join(result)


@click.group(context_settings=CONTEXT_SETTINGS)
@click.version_option(__version__)
def cli():
    pass


#
# Gen
#
@cli.command()  # @cli, not @click!
@click.option('-cf', '--config-filename', 'config_filename', default='config.yml', type=click.STRING, show_default=True, help='the name of the local config file.')
@click.option('-cu', '--config-url', 'config_url', type=click.STRING, help='the URL to a remote config file')
@click.option('-de', '--del-empty-lines', 'del_empty_lines', default=True, show_default=True, help='remove empty lines from the docker-compose.yml file.')
@click.option('--structure', 'structure', type=click.Choice(['flat', 'subfolder']), default='subfolder',
              help='defines the where the stack will be generated '
                   'flat : as in same folder as script generate the stack into same folder as config.yml'
                   'subfolder : generate the stack into a subfolder, which by default is the name of the platform provided when initializing the stack'
              )
@click.option('-v', '--verbose', is_flag=True, default=False, show_default=True, help='Verbose logging')
def gen(config_filename, config_url, del_empty_lines, structure, verbose):
    """Generates all the needed artifacts for the docker-based modern (data) platform.
    
    The stack configuration can either be passed as a local file (using the --config-filename option or using the default name 'config.yml') or as an URL
    referencing a file on the Internet (using the --config-url option).
    """
    click.echo(f'gen: config-filename = {config_filename}, structure = {structure}')

    with open(rf'{config_filename}') as file:
        yaml = ruamel.yaml.YAML()
        config_yml = yaml.load(file)
        platys_config = config_yml.get('platys')

        if platys_config is None:
            logging.error(f'Unable to parse config file please ensure the yml file has the proper configuration under the platys tag')
            sys.exit()

        if platys_config["platform-name"] is None or platys_config["stack-image-name"] is None or platys_config["stack-image-version"] is None:
            logging.error(f'The config file is not properly formatted or missing information '
                          f'please ensure [platform-name], [stack-image-name] and [stack-image-version] are properly configured')
            sys.exit()

    if verbose:
        print(f'using configuration file {config_filename}')
        print(f'with values '
              f' platform-name: {platys_config["platform-name"]}'
              f' stack-image-name: {platys_config["stack-image-name"]}'
              f' stack-image-version: {platys_config["stack-image-version"]}'
              )

    destination = Path().absolute()

    if structure == "subfolder":
        # create the folder if not exists
        destination = destination / platys_config['platform-name']
        Path(destination).mkdir(parents=True, exist_ok=True)

    print(f'generating stack on destination [{destination}]')

    client = docker.from_env()
    dp_container = client.containers.run(image=f'{platys_config["stack-image-name"]}:{platys_config["stack-image-version"]}',
                                         auto_remove=True, detach=True,
                                         volumes=[
                                             str(Path().absolute()) + '/config.yml:/tmp/config.yml',
                                             str(destination) + ':/opt/mdps-gen/destination'
                                         ],
                                         environment=[
                                             f"CONFIG_URL={config_url}",
                                             f"VERBOSE={int(verbose == True)}",
                                             f"DEL_EMPTY_LINES={int(del_empty_lines == True)}",
                                         ]
                                         )

    for line in dp_container.logs(stream=True):
        print(line.strip())


#
# Init
#

@cli.command()
@click.option('-n', '--platform-name', 'platform_name', type=click.STRING, required=True, help='the name of the platform to generate.')
@click.option('-sn', '--stack-name', 'stack_name', default='trivadis/platys-modern-data-platform', type=click.STRING, show_default=True, help='the platform stack image')
@click.option('-sv', '--stack-version', 'stack_version', default='latest', type=click.STRING, show_default=True, help='the platform stack image version to use')
@click.option('-cf', '--config-filename', 'config_filename', default='config.yml', type=click.STRING, show_default=True, help='the name of the local config file.')
@click.option('-sc', '--seed-config', 'seed_config', type=click.STRING, help='the name of a predefined stack to base this new platform on')
@click.option('-f', '--force', is_flag=True, help='If specified, this command will overwrite any existing config file')
@click.option('-hw', '--hw-arch', 'hw_arch', type=click.Choice(['ARM', 'ARM64', 'x86-64']), default='x86-64', help='Hardware architecture for the platform')
@click.option('-s', '--enable-services', 'enable_services', help='List of services to enable in the config file')
def init(platform_name, stack_name, stack_version, config_filename, seed_config, force, hw_arch, enable_services):
    """Initializes the current directory to be the root for the Modern (Data) Platform by creating an initial
    config file, if one does not already exists.
    
    The stack to use as well as its version need to be passed by the --stack-image-name and --stack-image-version options.
    By default 'config.yml' is used for the name of the config file, which is created by the init.
    """
    click.echo('Will create the folder with a base config file')

    if not force and os.path.isfile('config.yml'):
        print("config.yml already exists if you want to override it use the [-f] option")
    else:
        tar_config = pull_config(stack_name, stack_version)
        # extract the config file from the tar in to the current folder
        tar_file = tarfile.open(tar_config)
        tar_file.extractall(path="./")
        tar_file.close()

    if enable_services:
        yaml = ruamel.yaml.YAML()
        yaml.indent(sequence=18)
        yaml.preserve_quotes = True

        services = enable_services.split(',')

        slim_yml = {}

        with open(os.path.join(sys.path[0], "config.yml"), 'r') as file:
            config_yml = yaml.load(file)

            for s in services:
                if s + '_enable' in config_yml:
                    config_yml[s + '_enable'] = True

        keys_to_del = []

        for key, value in config_yml.items():
            if not contained(services, key) and key != "platys":
                keys_to_del.append(key)

        for key in [key for key in config_yml if key in keys_to_del]:
            del config_yml[key]

        with open(os.path.join(sys.path[0], "config.yml"), 'w') as file:
            yaml.dump(config_yml, file, transform=PushRootLeft(6))

        print_banner()


def contained(services, k):



    for s in services:
        pattern = re.compile(s+'_[a-z]+')
        if pattern.match(k):
            return True

    return False


def print_banner():
    with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'init_banner.txt'), 'r') as f:
        for line in f:
            print(line.rstrip())


@cli.command("stacks")
def list_predef_stacks():
    """Lists the predefined stacks available for the init"""

    client = get_docker()
    # make this dynamic from an argument
    container = client.containers.create(image='trivadis/platys-modern-data-platform:1.2.0g', auto_remove=False)
    container.start()

    log = container.exec_run('ls /opt/mdps-gen/seed-stacks',
                             stderr=True,
                             stdout=True)

    # collect the seed stacks present in the 'seed-stacks' folder
    # please note that for it to be considered stacks should be uppercase characters as well as _ or -
    stacks = []
    for line in log:
        stack = re.search("([A-Z0-9_-]+).yml", str(line))
        if stack is not None:
            stacks.append(stack.group(1))

    print(*stacks)

    container.stop()
    container.remove()


@cli.command("list_services")
@click.option('-sn', '--stack-name', 'stack_name', default='trivadis/platys-modern-data-platform', type=click.STRING, show_default=True, help='the platform stack image')
@click.option('-sv', '--stack-version', 'stack_version', default='latest', type=click.STRING, show_default=True, help='the platform stack image version to use')
def list_services(stack_name, stack_version):
    """Shows the services interfaces of the stack, web and/or apis"""

    tar_config = pull_config(stack_name, stack_version)

    # extract the config file from the tar in to the current folder
    tar_file = tarfile.open(tar_config)
    tar_file.extractall(path=tempfile.gettempdir())
    tar_file.close()
    yaml = ruamel.yaml.YAML()
    with open(rf'{tempfile.gettempdir()}/config.yml') as file:
        config_yml = yaml.load(file)
        for c in config_yml:
            service = re.search("([A-Z0-9_-]+)_enable", str(c))  # if variable follows regex it's considered a service and will be printed
            if service is not None:
                print(service.group(1))


# ----------------------------------------------
# Not yet defined only ideas
# --------------------------------------------------------

@cli.command()
def config():
    """Sets configuration"""
    click.echo('Will run the stack, once it is generated')


@cli.command()
def upload_stack():
    """Uploads the stack to a remote machine"""
    click.echo('Will run the stack, once it is generated')


@cli.command()
def start():
    """Starts the stack, once it is generated."""
    click.echo('Starts the stack, once it is generated')


@cli.command()
def stop():
    """Stops the stack, once it is generated."""
    click.echo('Stops the stack, once it is generated')


def pull_config(stack_name, stack_version):
    # init and start docker container
    client = docker.from_env()
    dp_container = client.containers.run(image=f'{stack_name}:{stack_version}', detach=True, auto_remove=True)

    # copy default config file (with default values to the current folder
    tar_config = tempfile.gettempdir() + '/config.tar'
    f = open(tar_config, 'wb')
    bits, stats = dp_container.get_archive('/opt/mdps-gen/vars/config.yml')

    for chunk in bits:
        f.write(chunk)
    f.close()

    return tar_config


def get_docker():
    return docker.from_env()


if __name__ == '__main__':
    cli()

cli.add_command(init)
cli.add_command(gen)
cli.add_command(list_predef_stacks)
cli.add_command(list_services)
