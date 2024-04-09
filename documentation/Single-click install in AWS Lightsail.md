# Single-click install in AWS Lightsail


Add the following script

```bash
export PLATYS_VERSION=2.4.0
export NETWORK_NAME=ens5
export USERNAME=ubuntu
export PASSWORD=abc123!

# Prepare Environment Variables 
export PUBLIC_IP=$(curl ipinfo.io/ip)
export DOCKER_HOST_IP=$(ip addr show ${NETWORK_NAME} | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# allow login by password
sudo sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
echo "${USERNAME}:${PASSWORD}"|chpasswd
sudo service sshd restart

# add alias "dataplatform" to /etc/hosts
echo "$DOCKER_HOST_IP     dataplatform" | sudo tee -a /etc/hosts

# Install Docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USERNAME

# Install Docker Compose Switch
sudo curl -fL https://github.com/docker/compose-switch/releases/latest/download/docker-compose-linux-amd64 -o /usr/local/bin/compose-switch
chmod +x /usr/local/bin/compose-switch
sudo update-alternatives --install /usr/local/bin/docker-compose docker-compose /usr/local/bin/compose-switch 99

# Install Platys
sudo curl -L "https://github.com/TrivadisPF/platys/releases/download/${PLATYS_VERSION}/platys_${PLATYS_VERSION}_linux_x86_64.tar.gz" -o /tmp/platys.tar.gz
tar zvxf /tmp/platys.tar.gz 
sudo mv platys /usr/local/bin/
sudo chown root:root /usr/local/bin/platys
sudo rm /tmp/platys.tar.gz 

cd /home/${USERNAME}
mkdir -p platys-demo
cd platys-demo

cat > config.yml << EOL
      platys:
        platform-name: 'platys-platform'
        platform-stack: 'trivadis/platys-modern-data-platform'
        platform-stack-version: '1.17.0-preview'
        structure: 'flat'

      # ========================================================================
      # Global configuration, valid for all or a group of services
      # ========================================================================
      # Timezone, use a Linux string such as Europe/Zurich or America/New_York
      use_timezone: ''
      # Name of the repository to use for private images, which are not on docker hub (currently only Oracle images)
      private_docker_repository_name: 'trivadis'
      # UID to use when using the "user" property in a service to override the user inside the container
      uid: '1000'

      # Optional environment identifier of this platys instance, by default take it from environment variable but can be changed to hardcoded value. 
      # Allowed values (taken from DataHub): dev, test, qa, uat, ei, pre, non_prod, prod, corp
      env: '${PLATYS_ENV}'

      data_centers: 'dc1,dc2'
      data_center_to_use: 0

      copy_cookbook_data_folder: true
      
      # ========================================================================
      # Platys Services
      # ========================================================================
      #
      # ===== Apache Zookeeper ========
      #
      ZOOKEEPER_enable: false
      ZOOKEEPER_volume_map_data: false
      ZOOKEEPER_nodes: 1 # either 1 or 3
      ZOOKEEPER_node_first_port: 2181
      #
      # ===== Apache Zookeeper Navigator ========
      #
      ZOOKEEPER_NAVIGATOR_enable: false
      #
      # ===== Apache Kafka ========
      #
      KAFKA_enable: true
      # one of enterprise, community
      KAFKA_edition: 'community'
      KAFKA_volume_map_data: false
      KAFKA_use_standard_port_for_external_interface: true
      KAFKA_datacenters: 1
      KAFKA_broker_nodes: 3
      KAFKA_broker_first_port: 9092
      KAFKA_use_kraft_mode: false
      KAFKA_internal_replication_factor: 3
      KAFKA_delete_topic_enable: true
      KAFKA_auto_create_topics_enable: false
      KAFKA_message_timestamp_type: CreateTime
      KAFKA_jmx_monitoring_prometheus_enable: false
      # KAFKA_log_segment_bytes:
      # KAFKA_log_retention_ms:
      # KAFKA_log_retention_hours:
      # KAFKA_log_retention_bytes:
      # KAFKA_compression_type:
      # KAFKA_min_insync_replicas:
      # KAFKA_replica_selector_class: org.apache.kafka.common.replica.RackAwareReplicaSelector
      KAFKA_confluent_log_placement_constraints:
      KAFKA_confluent_tier_feature: false
      KAFKA_confluent_tier_enable: false
      KAFKA_confluent_tier_backend: S3
      KAFKA_confluent_tier_s3_bucket: kafka-logs
      KAFKA_confluent_tier_s3_region: us-east-1
      KAFKA_confluent_tier_s3_aws_endpoint_override:
      KAFKA_confluent_tier_s3_force_path_style_access: false
      KAFKA_confluent_tier_local_hotset_bytes:
      KAFKA_confluent_tier_local_hotset_ms:
      KAFKA_confluent_tier_archiver_num_threads:
      KAFKA_confluent_tier_fetcher_num_threads:
      KAFKA_confluent_tier_topic_delete_check_interval_ms:
      KAFKA_confluent_tier_metadata_replication_factor: 1
      KAFKA_log4j_root_level: 'INFO'
      KAFKA_log4j_loggers: ''
      KAFKA_tools_log4j_level: 'INFO'
      #
      # ===== Kafka Console Utilities ========
      #
      KAFKA_CLI_enable: false
      #
      # ===== Kafka Connect ========
      #
      KAFKA_CONNECT_enable: true
      KAFKA_CONNECT_nodes: 1
      KAFKA_CONNECT_connectors:
      KAFKA_CONNECT_config_providers: 'file'
      KAFKA_CONNECT_config_providers_classes: 'org.apache.kafka.common.config.provider.FileConfigProvider'
      KAFKA_CONNECT_map_settings_file: false
      #
      # ===== kcat (used to be kafkacat) ========
      #
      KCAT_enable: false
      #
      # ===== AKHQ ========
      #
      AKHQ_enable: true
      AKHQ_read_only_mode: false
      AKHQ_topic_page_size: 25
      AKHQ_topic_data_size: 50
      AKHQ_topic_data_poll_timeout: 1000
      AKHQ_topic_data_kafka_max_message_length: 1000000
      AKHQ_default_view: HIDE_INTERNAL
      AKHQ_sort: OLDEST
      AKHQ_show_consumer_groups: true
      AKHQ_show_all_consumer_groups: true
      AKHQ_show_last_record: false
      #
      # ===== Wetty ========
      #
      WETTY_enable: true
      #
      # ===== Markdown Viewer ========
      #
      MARKDOWN_VIEWER_enable: true
      MARKDOWN_VIEWER_use_port_80: true
      MARKDOWN_VIEWER_use_public_ip: true
EOL
      
platys gen -v

# Install various Utilities
sudo apt-get install -y curl jq kafkacat tmux unzip

# Make Environment Variables persistent
sudo echo "export PUBLIC_IP=$PUBLIC_IP" | sudo tee -a /etc/profile.d/platys-platform-env.sh
sudo echo "export DOCKER_HOST_IP=$DOCKER_HOST_IP" | sudo tee -a /etc/profile.d/platys-platform-env.sh
sudo echo "export DATAPLATFORM_HOME=$PWD" | sudo tee -a /etc/profile.d/platys-platform-env.sh

# Startup Environment
docker-compose up -d
```