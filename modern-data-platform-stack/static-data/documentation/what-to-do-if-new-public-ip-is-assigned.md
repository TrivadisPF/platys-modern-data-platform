# What to do when the Public IP address has been changed?

This short instruction shows what to do when you have a running Platys stack and the Public IP address of the Docker host has been changed (this can happen if your docker host is running in a cloud VM). 

Some services of platys will no longer run correctly, if the IP address changes, therefore the stack has to be stopped and removed and then started again. Therefore you should **try to avoid a change of the IP address**, i.e. in the cloud by assigning a stack IP address!


You can check what your IP was when running the stack by showing the value of the PUBLIC_IP variable

```
echo $PUBLIC_IP
```

In the code blocks below we assume that the `DATAPLATFORM_HOME` variable is set and points to the `docker` folder where the metadata on the docker compose stack is located (the folder holding the `docker-compose.yml` file). 

Navigate into the stack and stop and remove all the services. Be aware that all the data inside your running container will be removed! 

```
cd $DATAPLATFORM_HOME

docker-compose down
```

Change the environment variables to hold the new IP address

```
export PUBLIC_IP=$(curl ipinfo.io/ip)
export DOCKER_HOST_IP=$(ip addr show ${NETWORK_NAME} | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
```

Check that the value of the variable is the correct IP address

```
echo $PUBLIC_IP
```

Update the `.bash_profile` script to relect the new IP address (so that after a new login it will be correct).

Open the file with an editor (change the username variable to your current user)

```
export USERNAME=ubuntu
nano /home/$USERNAME/.bash_profile
```

Save the file with **Ctrl-O** and exit with **Ctrl-X**. 

Restart the stack


```
cd $DATAPLATFORM_HOME

docker-compose up -d
```

Check the log files

```
docker-compse logs -f
```


