# Modern Data Platform Stack für Development beim AWS-ONE Projekt

Im folgenden ist beschrieben, wie der Stack gestartet werden kann und auf was es zu achten gilt. 

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

## Spark History Server

Für den Spark History Server muss der Folder zurzeit noch manuell erstellt werden:

```
docker exec -ti hadoop-client hadoop fs -mkdir -p /spark/logs
```

## Verfügbare Services

Die wichtigsten Services:

* Zeppelin: <http://analyticsplatform:38081>
* Minio Browser: <http://analyticsplatform:9000>
* Hue: <http://analyticsplatform:28888>
* StreamSets: <http://analyticsplatform:18630>
* Spark UI: <http://analyticsplatform:8080>
* Spark History Server: <http://analyticsplatform:18080>
* Hadoop Namenode: <http://analyticsplatform:9870>
* Yarn Ressource Manager: <http://analyticsplatform:8088>
* Kafka Manager: <http://analyticsplatform:29000>
* Kafka HQ: <http://analyticsplatform:28082>


## Spark

Testen von Spark über das CLI

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

## ToDo

 * Livy richtig konfigurieren
 * Konfiguration auf externes S3 einrichten
 *  