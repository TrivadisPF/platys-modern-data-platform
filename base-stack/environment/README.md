# Environments

In this documents various options are described for getting an environment setup. 

## Local VM

## AWS Lightsail
To start the whole stack on AWS Lightsail, use the following script

```
# Install Docker and Docker Compose
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"
apt-get install -y docker-ce
sudo usermod -a -G docker $USER

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install wget
apt-get install -y wget

# Install kafkacat
apt-get install -y kafkacat

# Prepare Environment
export PUBLIC_IP=$(curl ipinfo.io/ip)
export DOCKER_HOST_IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
git clone https://github.com/TrivadisBDS/modern-data-analytics-stack.git
cd modern-data-analytics-stack/docker
mkdir kafka-connect

# Startup Environment
docker-compose up
```

You can check the log of the script by connecting to the lightsail instance console and executing

```
tail -f /var/log/cloud-init-output.log --lines 1000
```

## Browser Bookmarks für Chrome

In the folder `browser-bookmarks` you can find a file which can be imported into Google Chrome to get bookmarks for all the applications which are part of the stack. In order for them to work you have to add the alias `analyticsplatform` to the `/etc/hosts` file.

