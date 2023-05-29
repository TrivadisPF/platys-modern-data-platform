# Setup necessary environment variables

Now the Platform is ready to be started. Before doing that, you have to create some environment variables, depending on the services you use. In minimum you should create

* `DOCKER_HOST_IP` - the IP address of the network interface of the Docker Host
* `PUBLIC_IP` - the IP address of the public network interface of the Docker Host (different to `DOCKER_HOST_IP` if in a public cloud environment

## Linux or Mac

First let's get the network interface name

```
$ ip addr
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:3a:82:45 brd ff:ff:ff:ff:ff:ff
    altname enp2s1
```    

and set it as a variable

```
export NETWORK_NAME=ens33
```

If the Docker host is running in the cloud (as a VM), where a specific public IP address is needed to reach it, perform this command

```bash
export PUBLIC_IP=$(curl ipinfo.io/ip)
```

otherwise this command

```bash
export PUBLIC_IP=$(ip addr show $NETWORK_NAME | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
```

Additionally set the `DOCKER_HOST_IP` to the IP address of the machine (make sure that `$NETWORK_NAME` has been set correctly)

```bash
export DOCKER_HOST_IP=$(ip addr show $NETWORK_NAME | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
```

Now persist these two environment variables, so that they are available after a logout.

You can set these environment variables persistently on the machine (`/etc/environment`) or user (`~/.pam_environment` or `~/.bash_profile`) level. The following script sets the `.bash_profile` in the user home.


```bash
# Prepare Environment Variables into .bash_profile file
printf "export PUBLIC_IP=$PUBLIC_IP\n" >> /home/$USER/.bash_profile
printf "export DOCKER_HOST_IP=$DOCKER_HOST_IP\n" >> /home/$USER/.bash_profile
printf "\n" >> /home/$USER/.bash_profile
sudo chown ${USER}:${USER} /home/$USER/.bash_profile
```

Another option is to use the `.env` file in the folder where the `docker-compose.yml` file is located. All environment variables set in there are used when the docker compose environment is started. 

## Windows

t.b.d.
