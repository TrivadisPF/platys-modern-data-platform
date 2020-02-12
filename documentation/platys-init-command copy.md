# platys init

```
Usage: platys init [OPTIONS]

  Initializes the current directory to be the root for the Modern (Data)
  Platform by creating an initial config file, if one does not already
  exists.

  The stack to use as well as its version need to be passed by the --stack-
  image-name and --stack-image-version options. By default 'config.yml' is
  used for the name of the config file, which is created by the init.

Options:
  -n, --platform-name TEXT        the name of the platform to generate.
                                  [required]
  -sn, --stack-name TEXT          the platform stack image  [default:
                                  trivadis/platys-modern-data-platform]
  -sv, --stack-version TEXT       the platform stack image version to use
                                  [default: latest]
  -cf, --config-filename TEXT     the name of the local config file.
                                  [default: config.yml]
  -sc, --seed-config TEXT         the name of a predefined stack to base this
                                  new platform on
  -f, --force                     If specified, this command will overwrite
                                  any existing config file
  -hw, --hw-arch [ARM|ARM64|x86-64]
                                  Hardware architecture for the platform
  -s, --enable-services TEXT      List of services to enable in the config
                                  file
  -h, --help                      Show this message and exit.
```

