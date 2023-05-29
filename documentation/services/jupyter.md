# Jupyter

Open-source software, open standards, and services for interactive computing across dozens of programming languages.

**[Website](https://jupyter.org/)** | **[Documentation](https://jupyter.org/documentation)** | **[GitHub](https://github.com/jupyter/notebook)**

## How to enable?

```
platys init --enable-services JUPYTER
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28888>. The token for the login has either be specified in the `config.yml` (`JUPYTER_token`) or if not set, the generated token can be retrieved from the log (`docker logs -f jupyter`). 

If you enable the `all-spark` edition and run spark, then the Spark UI will be available at <http://dataplatform:14040>.