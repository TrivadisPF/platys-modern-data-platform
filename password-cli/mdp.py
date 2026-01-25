import click  # Assume we're using Click for the CLI, but you could use argparse, Typer, etc.
import yaml
import bcrypt
from password_generator import PasswordGenerator
from jinja2 import Environment, Template
from jinja2 import Environment, FileSystemLoader

def gen_password(var):
    pwo = PasswordGenerator()

    password = pwo.generate()
    if var.endswith("HASH10"):
        print(var)
        salt = bcrypt.gensalt(rounds=10)
        hashed_password = bcrypt.hashpw(password.encode("utf-8"), salt)
        return hashed_password.decode("utf-8") + "  # " + password
    else:
        return password

@click.command()
@click.option("--name", prompt="Your name", help="The person to greet.")
def greet(name):
    """Simple program that greets NAME."""
    print(f"Hello, {name}!")

    template = Template("""
                {% set ns = namespace(var_list=[]) -%}
                {% for service in services.items() | sort() -%}
                {%- if service[1].init is not defined -%}
                {%- if service[1].labels and service[1].labels['com.platys.password.envvars'] is defined and service[1].labels['com.platys.password.envvars'] | length -%} {% for var in service[1].labels['com.platys.password.envvars'].split(',') -%}
                {% if var not in ns.var_list -%}
                    {% set ns.var_list = ns.var_list + [var] -%}
                {% endif -%}
                {% endfor -%}
                {%- endif -%}  
                {%- endif -%}  
                {% endfor -%}

                {% for var in ns.var_list | sort() -%}
                {{var}} = {{ gen_password(var) }} 
                {% endfor -%}
                """)

    with open("/Users/guido.schmutz/Documents/GitHub/trivadispf/eadp/platform/platform-in-a-box/platys-eadp/docker-compose.yml", "r") as yaml_file:
      data = yaml.safe_load(yaml_file)
    
    data["gen_password"]=gen_password
    output = template.render(data)

    print (output)


if __name__ == "__main__":
    greet()
