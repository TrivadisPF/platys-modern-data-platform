# mdp init

```
Usage: mdp init [OPTIONS] 

  Initializes the current directory to be a Modern Data Platform Stack
  environment by creating an initial stack config file, if one does not
  already exists.

  The stack to use as well as its version need to be passed by the --stack-name 
  and --stack-version options. By default 'config.yml' is
  used for the name of the config file, which is created by the init.

Options:
  -n, --platform-name TEXT     the name of the platform stack to generate.
                               [required]
  -in, --stack-name TEXT       the modern data platform stack image  [default:
                               trivadis/modern-data-platform-stack-generator]
  -iv, --stack-version TEXT    the modern data platform stack image version to
                               use  [default: latest]
  -sc, --seed-config TEXT      the name of a predefined stack to base this new
                               platform on
  -f, --force                  If specified, this command will overwrite any
                               existing config file
  -hw, --hw-arch [ARM|ARM64|x86-64]
                               Hardware architecture for the platform
  -h, --help                   Show this message and exit.

```

