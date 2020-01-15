# mdp gen

```
Usage: mdp gen [OPTIONS] 

  Generates a docker-based Modern Data Platform Stack.

  The stack configuration can either be passed as a local file (using the
  default file name 'config.yml') or as an URL referencing a file on the Internet 
  (using the --config-url option).

Options:

  -cu, --config-url TEXT          the URL to a remote config file
  --del-empty-lines / --no-del-emptylines
                                  remove empty lines from the docker-
                                  compose.yml file.  [default: True]
  --flat                          generate the stack into same folder as
                                  config.yml
  --subfolder                     generate the stack into a subfolder, which
                                  by default is the name of the platform
                                  provided when initializing the stack
  -v, --verbose                   Verbose logging  [default: False]
  -h, --help                      Show this message and exit.
```

