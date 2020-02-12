# platys gen

```
Usage: platys gen [OPTIONS]

  Generates all the needed artifacts for the docker-based modern (data)
  platform.

  The stack configuration can either be passed as a local file (using the
  --config-filename option or using the default name 'config.yml') or as an
  URL referencing a file on the Internet (using the --config-url option).

Options:
  -cf, --config-filename TEXT   the name of the local config file.  [default:
                                config.yml]
  -cu, --config-url TEXT        the URL to a remote config file
  -de, --del-empty-lines TEXT   remove empty lines from the docker-compose.yml
                                file.  [default: True]
  --structure [flat|subfolder]  defines the where the stack will be generated
                                flat : as in same folder as script generate
                                the stack into same folder as
                                config.ymlsubfolder : generate the stack into
                                a subfolder, which by default is the name of
                                the platform provided when initializing the
                                stack
  -v, --verbose                 Verbose logging  [default: False]
  -h, --help                    Show this message and exit.
```
