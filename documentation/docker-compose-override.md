# Adding additional services not supported by a Platform Stack

If you have a service which is not supported by the Platform Stack you are using or you want to add an additional property to a generated service, then you should **never** manually change the `docker-compose.yml` as it then prevents a re-generation using `platys gen`. 

A much better way is using [the method of using multiple compose files](https://docs.docker.com/compose/extends/#multiple-compose-files) and creating a `docker-compose.override.yml` file.

Just create this new file in the same folder as the `docker-compose.yml`, name it `docker-compose.override.yml` and add the a header similar to the one, where the version should be the same as the one as in the generated `docker-compose.yml` file.

You can either add new services or extend properties/settings of existing services.

```yaml
services:
  <add your new service definitions here ...>
  
  existing-service:
    ...
    environment:
      <add new or overwrite existing configurations here...>
```

This should always be the preferred way to add new services or change existing ones. 

If your service also exposes a service, then you can add the necessary labels to inlude it in the services list generated. 

```yaml
services:
  <add your new service definitions here ...>
  
  existing-service:
    ...
    labels:
      com.platys.name: my-service
      com.platys.description: UI for the service
      com.platys.webui.title: The webui of the service
      com.platys.webui.url: http://dataplatform:8081        
    ports:
      - "8081:8081"
    environment:
      <add new or overwrite existing configurations here...>
```

It will be automatically included when running the `markdown-renderer` upon starting the compose stack.

Of course you can also ask for inclusion of the service by creating a new issue on this GitHub project. 
   
