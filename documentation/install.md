# Install Modern Data Platform Stack Generator (MDP)

You can run MDP on macOS, Windows, and 64-bit Linux.

## Prerequisites

The MDP Stack Generator relies on the Docker Engine for any meaningful work, so make sure you have Docker Engine installed either locally or remote, depending on your setup.

  * On desktop systems install Docker Desktop for Mac and Windows
  * On Linux systems, install the Docker for your OS as described on the Get Docker page

For running the Modern Data Platform Stack you also have to install Docker-Compose. 

You also need an internet connection in order to download the necessary images. 

## Install MDP

Follow the instructions below to install the MDP Stack Generator on a Mac or Linux systems. Running on Windows is not yet supported. 

* Run this command to download the current stable release of the MDP Stack Generator:

```
sudo curl -L "https://github.com/TrivadisPF/modern-data-platform-stack/releases/download/2.0.0-preview/mdp.sh" -o /usr/local/bin/mdp
```

* Apply executable permissions to the binary:

```
sudo chmod +x /usr/local/bin/mdp 
```

Use the `--version` option to check that the generator has been installed successfully.

```
$ mdp --version
Trivadis Docker-based Modern Data Platform Generator v2.0.0
```
   
## Uninstallation

To uninstall `mdp` perform

```
sudo rm /usr/local/bin/mdp
```
   
## Where to go next

* [Getting Started](getting-started.md)
* [Explore the full list of MDP commands](commands.md)
* [MDP configuration file reference](configuration.md)