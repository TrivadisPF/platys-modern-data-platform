# DataHub

Data ecosystems are diverse — too diverse. DataHub's extensible metadata platform enables data discovery, data observability and federated governance that helps you tame this complexity.

**[Website](https://datahubproject.io/)** | **[Documentation](https://datahubproject.io/docs/)** | **[GitHub](https://github.com/linkedin/datahub)**

## How to enable?

```
platys init --enable-services DATAHUB
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28144> and log in with user `datahub` and password `datahub`.

### How to change the password of the `datahub`user?

Create a file `user.props` in `./security/datahub` and add a line with `datahub:<password>`

```
datahub:abc123!
```

Enable the mapping of `user.props` into the docker container

```yaml
      DATAHUB_map_user_props: true
```

and re-run `platys gen`. 

