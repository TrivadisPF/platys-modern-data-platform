## Start on Lightsail

The following script can be used to start the stack on Lightsail

```
# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"
apt-get install -y docker-ce
sudo usermod -aG docker ubuntu

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Prepare Environment Variables
export PUBLIC_IP=$(curl ipinfo.io/ip)
export DOCKER_HOST_IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# needed for elasticsearch
sudo sysctl -w vm.max_map_count=262144   

# Get the project
cd /home/ubuntu 
git clone https://github.com/TrivadisPF/modern-data-analytics-stack.git
chown -R ubuntu:ubuntu modern-data-analytics-stack
cd modern-data-analytics-stack/customer-poc/aws-one/docker
# Startup Environment
sudo -E docker-compose up -d
```



## Services

* Hue: <http://analyticsplatform:28888>



## Spark

```
docker exec -ti spark-master spark-shell spark.version

spark.version
:quit
```

## Zeppelin

To work with Spark, the following dependency is needed on the **Spark** interpreter:
 
 * `org.apache.commons:commons-lang3:3.5` 


And if you want to use S3, the following 7 additional dependencies have to be added:

 * `org.apache.httpcomponents:httpclient:4.5.8`
 * `com.amazonaws:aws-java-sdk-core:1.11.524`
 * `com.amazonaws:aws-java-sdk-kms:1.11.524`
 * `com.amazonaws:aws-java-sdk:1.11.524`
 * `com.amazonaws:aws-java-sdk-s3:1.11.524`
 * `joda-time:joda-time:2.9.9`
 * `org.apache.hadoop:hadoop-aws:3.1.1`	

