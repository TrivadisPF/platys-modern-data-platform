# Python

Python is a programming language that lets you work quickly and integrate systems more effectively.

**[Homepage](https://www.python.org/)** | **[Documentation](https://www.python.org/doc/)** | **[GitHub](https://github.com/python/cpython)**

## How to enable?

```
platys init --enable-services PYTHON
platys gen
```

## How to use it?


### Running multiple scripts with supervisord

Set `PYTHON_supervisord_enabled: true` to run the container under [supervisord](http://supervisord.org/). `PYTHON_script_to_run` is then ignored and the programs are defined in `supervisord.conf` (name configurable with `PYTHON_supervisord_config_file`) inside the folder given by `PYTHON_artefacts_folder`, which is mounted at `/app`:

```ini
[supervisord]
nodaemon=true

[program:app1]
command=python /app/app1.py
autorestart=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
redirect_stderr=true

[program:app2]
command=python /app/app2.py
autorestart=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
redirect_stderr=true
```
