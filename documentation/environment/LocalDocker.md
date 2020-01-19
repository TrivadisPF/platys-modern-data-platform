# Provision on Local Docker Environment

Make sure that you have Docker and Docker Compose running on your local environment. To run docker on windows you need to have Windows 10.

* Mac: <https://docs.docker.com/docker-for-mac/>
* Windows 10: <https://docs.docker.com/docker-for-windows/install/>

## Prepare Environment

In the Virtual Machine, start a terminal window and execute the following commands. 

First let's add the environment variables. Make sure to adapt the network interface (**ens33** according to your environment. You can retrieve the interface name by using **ipconfig** on windows or **ifconfig* on Mac/Linux. 

```
# Set environment variables to match the IP address of the local machine
export PUBLIC_IP=10.1.215.134
export DOCKER_HOST_IP=10.1.215.134
```

Now for Elasticsearch to run properly, we have to increase the `vm.max_map_count` parameter like shown below.  

```
# needed for elasticsearch
sudo sysctl -w vm.max_map_count=262144   
```

Now let's checkout the NoSQL Workshop project from GitHub:

Navigate to your local folder, where you want to keep the workshop and execute the `git clone` command

```
# Get the project
git clone https://github.com/TrivadisBDS/modern-data-analytics-stack.git
cd modern-data-analytics-stack/base-stack/docker
```

## Start Environment

And finally let's start the environment:

```
# Make sure that the environment is not running
docker-compose down

# Startup Environment
docker-compose up -d
```

The environment should start immediately, as all the necessary images should already be available in the local docker image registry. 

The output should be similar to the one below. 

![Alt Image Text](./images/start-env-docker.png "StartDocker")

Your instance is now ready to use. Complete the post installation steps documented the [here](README.md).

## Stop environment

To stop the environment, execute the following command:

```
docker-compose stop
```

after that it can be re-started using `docker-compose start`.

To stop and remove all running container, execute the following command:

```
docker-compose down
```

