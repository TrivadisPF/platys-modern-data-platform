# Running Platys via Vagrant

You can use the provided Vargrantfile to start a VM with all the necessary pre-requisites as well as the latest version of Platys installed. 

## Install Vagrant

First install Vagrant from [the Vagrant Download page](https://www.vagrantup.com/downloads.html).

Check that vagrant is installed by running it with the `--version` option

```
vagrant --version
```

Next, install the `vagrant-docker-compose` plugin

```
vagrant plugin install vagrant-docker-compose
```

## Create and start the VM

Create a new folder and copy the [`Vagrantfile`](./Vagrantfile) into this folder.

If you want to use another provider than the [`virtualbox`](https://www.vagrantup.com/docs/virtualbox/) default provider, specify it using the `VAGRANT_DEFAULT_PROVIDER` environment variable:

```
export VAGRANT_DEFAULT_PROVIDER=vmware_desktop
```

Now you are ready to start and provision the Vagrant environment:

```
vagrant up 
```

It will first download the virtual machine and then install Docker, Docker Compose and Platys. This will take a while. After that you have a fully working installation of Platys available.

To connect to the vagrant environment, execute

```
vagrant ssh
```

Now you can start using one of the supported Platys platforms by first creating the `config.yml` file and then using the generator for creating the `docker-compose.yml` file. Follow the steps in [Getting Started with platys and modern-data-platform stack](../platform-stacks/modern-data-platform/documentation/getting-started.md) for an example.

## Suspending and Restart the VM

To suspend a vagrant environment
```
vagrant suspend
```

And to later restart it

```
vagrant resume
```


## Destroy the VM

To stop and destroy the vagrant environment use 

```
vagrant destroy
```
