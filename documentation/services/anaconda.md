# Anaconda

Anaconda Distribution is a Python/R data science distribution and a collection of over 7,500+ open-source packages, which includes a package and environment manager. Anaconda Distribution is platform-agnostic, so you can use it whether you are on Windows, macOS, or Linux. It’s also is free to install and offers free community support.

**[Website](https://www.anaconda.com/)** | **[Documentation](https://docs.anaconda.com/#)** | **[GitHub](https://github.com/jupyter/notebook)**

## How to enable?

```
platys init --enable-services ANACONDA
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28889>. The token for the login has either be specified in the `config.yml` (`ANACONDA_JUPYTER_token`) or if not set, the generated token can be retrieved from the log (`docker logs -f anaconda`). 
