# Podman, with Docker-Compose and Platys on Centos8

```bash
systemctl enable --now cockpit.socket
```

```
sudo passwd
```

```bash
sudo nano /etc/ssh/sshd_config
```

search for the `PasswordAuthentication` line and make sure it ends with `yes`.

Restart the SSH service by typing the following command:

```bash
sudo systemctl restart sshd
```

Converting from CentOS Linux 8 to CentOS Stream 8

```bash
dnf --disablerepo '*' --enablerepo extras swap centos-linux-repos centos-stream-repos --allowerasing
dnf distro-sync
```
                                
                            
setup podman and podman-docker

```
sudo dnf install -y podman netavark podman-docker
```

Set up the Podman socket in order for Docker Compose to work:

```bash
sudo systemctl enable podman.socket
sudo systemctl start podman.socket
sudo systemctl status podman.socket
```

```bash
sudo curl -H "Content-Type: application/json" --unix-socket /var/run/docker.sock http://localhost/_ping
```

install docker-compose

```bash
curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

install platys

```bash
sudo curl -L "https://github.com/TrivadisPF/platys/releases/download/2.4.3/platys_2.4.3_linux_x86_64.tar.gz" -o /tmp/platys.tar.gz

cd /tmp
tar zvxf /tmp/platys.tar.gz 
sudo mv platys /usr/local/bin/
sudo chown root:root /usr/local/bin/platys
sudo rm /tmp/platys.tar.gz 

platys version
```

```
podman info | grep -i -A3 net
```

if it does not show `networkBackend: netavark` then 

create a file

```bash
nano /etc/containers/containers.conf
```

and add

```properties
[network]

# Explicitly force "netavark" as to not use the outdated CNI networking, which it would not apply otherwise as long as old stuff is there.
# This may be removed once all containers were upgraded?
# see https://discussion.fedoraproject.org/t/how-to-get-podman-dns-plugin-container-name-resolution-to-work-in-fedora-coreos-36-podman-plugins-podman-dnsname/39493/5?u=rugk

# official doc:
# Network backend determines what network driver will be used to set up and tear down container networks.
# Valid values are "cni" and "netavark".
# The default value is empty which means that it will automatically choose CNI or netavark. If there are
# already containers/images or CNI networks preset it will choose CNI.
#
# Before changing this value all containers must be stopped otherwise it is likely that
# iptables rules and network interfaces might leak on the host. A reboot will fix this.
#
network_backend = "netavark"
```

now reboot

```bash
mkdir platys-demo-platform
cd platys-demo-platform
platys init -n demo-platform --stack trivadis/platys-modern-data-platform --stack-version 1.15.0 --structure flat
```
