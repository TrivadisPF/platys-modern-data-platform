![](tri_logo_high.jpg)

[![License](http://img.shields.io/:license-Apache%202-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)
[![Code Climate](https://codeclimate.com/github/codeclimate/codeclimate/badges/gpa.svg)](https://codeclimate.com/github/TrivadisPF/modern-data-platform-stack)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# platys - Trivadis Platform in a Box
Copyright (c) 2019-2020 Trivadis


Install the required packages

```bash
pip3 install docker
pip3 install ruamel.yaml==0.16.4
pip3 install click
```

Build the binaries with the appropriate options

```bash
sudo apt-get install -y nuitka
pip3 install nuitka
python3 -m nuitka --follow-imports --standalone --show-progress platys.py
```
