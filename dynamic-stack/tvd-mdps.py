import click

__version__ = '2.0.0'
CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.group(context_settings=CONTEXT_SETTINGS)
@click.version_option(__version__)
def cli():
    pass


#
# Gen
#
@cli.command()   # @cli, not @click!
@click.option('-cf', '--config-filename', 'configFilename', default='stack-config.yml', type=click.STRING, show_default=True, help='the name of the local config file.')
@click.option('-cu', '--config-url', 'configUrl', type=click.STRING, help='the URL to a remote config file')
@click.option('--del-empty-lines/--no-del-emptylines', 'delEmptyLines', default=True, show_default=True, help='remove empty lines from the docker-compose.yml file.')
@click.option('--flat', 'stackorg', flag_value="flat", default=True, help='generate the stack into same folder as stack-config.yml')
@click.option('--subfolder', 'stackorg', flag_value="subfolder", help='generate the stack into a subfolder, which by default is the name of the platform provided when initializing the stack')
@click.option('-v', '--verbose', is_flag=True, default=False, show_default=True, help='Verbose logging' )
def gen(configFilename, configUrl, stackImage, stackVersion, delEmptyLines, stackorg, verbose):
    '''Generates a docker-based Modern Data Platform Stack.

    The stack configuration can either be passed as a local file (using the --config-filename option or using the default name 'stack-config.yml') or as an URL
    referencing a file on the Internet (using the --config-url option). 
    '''
    click.echo('gen: config-filename = %s, stack-image = %s, stack-version = %s, stackorg = %s' % (configFilename, stackImage, stackVersion, stackorg))

#
# Init
#
@cli.command() # @cli, not @click!
@click.option('-n', '--platform-name', 'platformName', type=click.STRING, required=True, help='the name of the platform stack to generate.')
@click.option('-in', '--stack-image-name', 'stackImage', default='modern-data-platform-stack-generator', type=click.STRING, show_default=True, help='the modern data platform stack image')
@click.option('-iv', '--stack-image-version', 'stackVersion', default='LATEST', type=click.STRING, show_default=True, help='the modern data platform stack image version to use')
@click.option('-cf', '--config-filename', 'configFilename', default='stack-config.yml', type=click.STRING, show_default=True, help='the name of the local config file.')
@click.option('-ps', '--predef-stack-config', 'predefStackConfig', type=click.STRING, help='the name of a predefined stack to base this new platform on')
@click.option('-f', '--force', is_flag=True, help='If specified, this command will overwrite any existing config file')
def init(platformName, stackimageName, stackimageVersion, configFilename, predefStackConfig, force):
    '''Initializes the current directory to be a Modern Data Platform Stack environment by creating an initial stack config file, if one does not already exists.

    The stack to use as well as its version need to be passed by the --stack-image-name and --stack-image-version options. 

    By default 'stack-config.yml' is used for the name of the config file, which is created by the init. 
    '''
    click.echo('Will create the folder with a base config file')

@cli.command()
def list_predef_stacks():
    '''Lists the predefined stacks available for the init'''
    click.echo('Will run the stack, once it is generated')

@cli.command()
def show_services():
    '''Shows the services interfaces of the stack, web and/or apis'''
    click.echo('Show the service interfaces of the stack')


# ---------------------------------------------- Not yet defined only ideas --------------------------------------------------------

@cli.command()
def config():
    '''Sets configuration'''
    click.echo('Will run the stack, once it is generated')

@cli.command()
def upload_stack():
    '''Uploads the stack to a remote machine'''
    click.echo('Will run the stack, once it is generated')

@cli.command()
def start():
    '''Starts the stack, once it is generated.'''
    click.echo('Starts the stack, once it is generated')

@cli.command()
def stop():
    '''Stops the stack, once it is generated.'''
    click.echo('Stops the stack, once it is generated')

if __name__ == '__main__':
    cli()