---
technologies:       kafka
version:				1.17.0
validated-at:			3.10.2023
---

# Kafka SASL/SCRAM Authentication

This recipe will show how to use Kafka with SASL/SCRAM Authentication enabled and the usage of a client (AKHQ) to access it.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started) with the following services enabled

```bash
platys init --enable-services KAFKA,AKHQ,KADECK -s trivadis/platys-modern-data-platform -w 1.17.0
```

edit `config.yml` and add the following configuration setting after the `KAFKA_enable`

```yaml
      KAFKA_enable=true
      
      KAFKA_security_protocol: 'SASL_PLAINTEXT'
      # either 'PLAIN', 'SCRAM-SHA-256' or 'SCRAM-SHA-512'
      KAFKA_sasl_mechanism: 'SCRAM-SHA-256'
      KAFKA_initial_users: 'broker:broker,connect:connect-secret,sschemaregistry:chemaregistry-secret,ksqldb:ksqldb-secret,client:client-secret'
      KAFKA_client_username: 'client'
      KAFKA_client_password: 'client-secret'
      KAFKA_authorizer_enable: false
      KAFKA_allow_everyone_if_no_acl_found: false
      KAFKA_super_users: 'broker,connect,client'

```

Now generate and start the platform 

```bash
platys gen

docker-compose up -d
```

## AKHQ

Navigate to AKHQ on <http://dataplatform:28107>.

## KaDeck

Navigate to KaDeck on <http://dataplatform:28313>, login as user `admin` with password `admin` and accept the license information.

Click on **+ Add Connection** and on the pop-up dialog, select **Apache Kafka** and click **Next**.

Enter the following settings:
  
  * **Connection Name**: `MyKafka`
  * **Connection Name**: `kafka-1:19092,kafka-2:19093`
  * **Security & Authentication**
  	 * **Security Protocol**: `SASL_PLAINTEXT`
  	 * **Sasl Jaas Config**: `org.apache.kafka.common.security.scram.ScramLoginModule required username="broker" password="broker";`
  	 * **Sasl Mechanism**: `SCRAM-SHA-256` 
  
Click on **Test connection** and a **Connection check successful** message should appear.

Click on **Create** to successfully create the connection.

## Command Line

**List all users**

```bash
docker exec -ti kafka-1 kafka-configs --zookeeper zookeeper-1:2181 --describe --entity-type users
```

and you should see the users in the log

```bash
...
[2023-10-03 20:37:59,855] INFO [ZooKeeperClient ConfigCommand] Connected. (kafka.zookeeper.ZooKeeperClient)
Configs for user-principal 'ksqldb' are SCRAM-SHA-512=salt=aXF0Yzh3bHhpbHlxYWx5cjZyMW9qa2kwbQ==,stored_key=lt5FvEAbOqkfYNwIloFE6h8AuSM5ZueoGIwPP7btV3rQ4r+85ftXCbybSJAxZHCaMsmJbJwCroDpPJRuxFbbNw==,server_key=5RP/+5S4Agcd+pXKw8EO7NyGrrzLceBgyuP03SxJ7kvZ+9ciE8OTD78iD850nX7/25BLvongubZzlPCWajCcdA==,iterations=4096,SCRAM-SHA-256=salt=NTBnZ3Z1aWx1dnUweHR6cXljNm9lOHE0ZQ==,stored_key=+g3occP5Pi1XM1oQjf9nP8x3lQrd6JYAmrx/TfiUn3o=,server_key=OFc7MDhPFeOm6PIRHBywL4NT6phtaPCgNl+3Tj69vv8=,iterations=4096
Configs for user-principal 'client' are SCRAM-SHA-512=salt=eHluZW1kNzNvcjg2OHluZzk2MDNqeHllaA==,stored_key=dHN31tVlvL6DC7eFabyCPdhZjc2BijFbxX4vmh7l/L/lvRHW16r7dnTGeA76jXRiBfeOLLkyUw7nh65gw+irrQ==,server_key=1y5Cev8lA8ygUsqzLmcMb73BqtI/ivl++MfonWVaC7XrJJOq50KB6es764Z4HjrUExT74b2GRMxz1u05fxIJvg==,iterations=4096,SCRAM-SHA-256=salt=MTZnam5jYTYwaWl2dGN3dmJiaHN3aTJmNjM=,stored_key=doDuhjE0Hpkq3U2INTuuHbqrXUivDIyq8Oqceck3i3k=,server_key=NCfC1b/iBx8wVZwTOXtRMUJnRlmoKrfecGmkp8/7p5Q=,iterations=4096
Configs for user-principal 'sschemaregistry' are SCRAM-SHA-512=salt=NmJ3aTlsazR3cWNudDRyZW9qMXRhY2w3eA==,stored_key=r64+7cdMZ1Z+inkDn+JtZ2aVBIg++Od/WlpvWfj2bgm80A5LOLglQ1Z86wmDTracOClXsEgPK5sNQ+6AucJjDw==,server_key=76wg9XkZLfgxQXsazC7gs7ifJjuXWm2KfsJkc1FlL11cCCioWezww1Df0nlspAzvlUqBz4M19kQ+j2aLnLwa+g==,iterations=4096,SCRAM-SHA-256=salt=czJ4bmJqbGlhdnU5aGVtdnhkeGg5cWVmbA==,stored_key=NSWGeDeoX6nqTZZWGP3klehxPbxFLHU5i2X1Ts6ozCw=,server_key=LL9tBIsJKV+dG44gDgcbQ9LUmjfZppcWp3RnnxobP7M=,iterations=4096
Configs for user-principal 'broker' are SCRAM-SHA-512=salt=a3c4YXVndnFsdDd4aWh4ODl0a2tkeXVtcg==,stored_key=bWyJdKsAhAUHuIT1qtpyYkypMZD/Oz9B7Z1qWXh6MlqEpP8jQf917h3OFtAac0fWWDx7Rekg+dNURjrYJpxyjA==,server_key=OIjLoTD/GiQdeXAEFlKCnbFs8M7L83WVk5r8V2qPSuoGTyhhwjwO2Spl+gV9l0JymWuzurNSc/ZyERPFpsqEbg==,iterations=4096,SCRAM-SHA-256=salt=MTB5bXJleWdtZ3lleXkwcmd2c3pjYTh5emY=,stored_key=PXzNiG8iJGHL5VeLUpPyHbuZdpjg5vCFW5Vfy9kAEiI=,server_key=sVnBfcdBLiUslEVwPIJt9yaMpSZvH5T5cVxSv2CkzCQ=,iterations=4096
Configs for user-principal 'connect' are SCRAM-SHA-512=salt=NDZvM3N3ZTRxdTM2d2hoMHl3NnAwY2VjOA==,stored_key=RSvEr+Dj3lVzi5AkDp07PPvQTB4eyNDCVnmSy8Q+EZuYpXROT1Mm2D5Qjm/BxkhVnlp2QyV8EBXdw3PZq27t8Q==,server_key=rr4qqSnQefOAQhEdYFKYjioiyndeqWkH8d/jbCQQ04SDzg/4pMiTY+UuOsqpBvX2nWoZ167eP6eoq6OddQQ/2g==,iterations=4096,SCRAM-SHA-256=salt=Yjc0MnR6a2drMDc1Z2k2OXh4NGZvY2Y3bA==,stored_key=TgF9/Itu8sX5EuPqjCV3OVl2Ishkubk+Bwq3JwuDX1M=,server_key=DoqYMzrksN75ZskQUpgxx3jsg1Aw9owy7zi5gathssg=,iterations=4096
[2023-10-03 20:38:00,258] INFO [ZooKeeperClient ConfigCommand] Closing. (kafka.zookeeper.ZooKeeperClient)
[2023-10-03 20:38:00,364] INFO Session: 0x10000873675000c closed (org.apache.zookeeper.ZooKeeper)
[2023-10-03 20:38:00,364] INFO EventThread shut down for session: 0x10000873675000c (org.apache.zookeeper.ClientCnxn)
[2023-10-03 20:38:00,367] INFO [ZooKeeperClient ConfigCommand] Closed. (kafka.zookeeper.ZooKeeperClient)
```

**Add a new user**

```bash
docker exec -ti kafka-1 kafka-configs --zookeeper zookeeper-1:2181 --alter --add-config 'SCRAM-SHA-256=[password=user-secret]' --entity-type users --entity-name new-user
```

**Remove a user**

```bash
docker exec -ti kafka-1 kafka-configs --zookeeper zookeeper-1:2181  --alter --delete-config 'SCRAM-SHA-256' --entity-type users --entity-name new-user
```
