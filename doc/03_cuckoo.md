# Cuckoo

This section details the requirements, installation and configuration of the main sandbox process.

## Requirements

### Python

Cuckoo runs on any reasonably recent version of python, this guide assumes Python version 2.7.9, the latest 2.x
available in Debian at time of writing. To check if python is already present on the host run

```
python --version
```

an answer similar to 

```
Python 2.7.9
```

will confirm Python is installed, while a `command not found` error will mean Python is missing.

To install Python and its development libraries (required later for installing the dependency libraries) 
you can run

```
apt-get install python python-dev
```

with root privileges.

### MongoDB

The main cuckoo component requires the [MongoDB](https://www.mongodb.com/) store to be available. This guide
will assume that the database is installed on the same host cuckoo runs on, to have the database separated just
replace the configuration, where relevant, with the required ip:port couple for the remote MongoDB server.

To install MongoDB server, client tools and development libraries (required later to install the Python client
libraries) on a Debian host simply run

```
apt-get install mongodb-server mongodb-clients mongodb-dev
```

This should provide a reasonably recent version of MongoDB, as found in the Debian repositories. If no such version
is available or if the version is too old, you can follow the instructions at [this page](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/)
for the latest instructions on obtaining and installing from the repositories provided by the MongoDB organization.

## Installation

Installing cuckoo requires a number of python of python dependencies. The fastest and most convenient way to
install all of them is to use a virtualenv and a service file using that particular python executable.

To install cuckoo, the guide will assume that the main root will reside in `/opt/cuckoo` simply clone the main repository with

```
git clone https://github.com/spender-sandbox/cuckoo-modified /opt/cuckoo
```

The next step is to create the virtualenv to hold all the python dependencies. To do so, assuming the virtualenv directory
is located in `/opt/cuckoo_venv/` run

```
virtualenv /opt/cuckoo_venv/
cd /opt/cuckoo_venv/
```
 
This will create the virtualenv and copy inside all required executables. To start working on the virtualenv run

```
source bin/activate
```

from within the virtualenv root directory (in this case `/opt/cuckoo_venv`) and install the dependencies from the
`requirements.txt` file located in the root of the cuckoo source tree.

```
pip install -r /opt/cuckoo/requirements.txt
```

Some development libraries might be required for the python libraries to build correctly, at the time of writing the following `-dev`
packages are required and can be installed by running

```
apt-get install python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg-dev libvirt-dev libgeoip-dev libfuzzy-dev
```

with root privileges.


## Configuration

### cuckoo.conf

The first file to edit is `conf/cuckoo.conf`, it contains the generic configuration options that you might want to verify before launching Cuckoo.
The file is largely commented and self-explaining, but some of the options you might want to pay more attention to are:

- `machinery` in `[cuckoo]` that defines which Machinery module you want Cuckoo to use to interact with your analysis machines. The value must 
be the name of the module without extension (ie: VirtualBox for the `virtualbox.conf` machinery configuration file)
- `ip` and `port` to define the bind address for the result server
- `connection` in the `[database]` section to define the location, username and password (using the default [SQLAlchemy Database URIS format](http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls))
of the database to connect to in order to store and retrieve analysis tasks and their results

### auxiliary.conf

This file defines the auxiliary files and scripts that are run together with the malware analysis job. The most common solution is to configure, as
is usually the default, the `tcpdump` option to point to a valid [TCPDump](http://www.tcpdump.org/) binary to intercept and analyse network traffic on the host.

### machinery.conf

This script defines the particular virtualization machinery that will be used to manage the virtual hosts. Due to the limited scope of this guide
the `VirtualBox` virtualization tool-chain will be assumed, please refer to the appropriate chapter for installation and configuration instructions.

The most important options are `mode`, to define whether to run with a graphical user interface or via the headless commands (more likely on a server),
the `path` to the VBoxManage main VirtualBox executable and a `machines` comma separated lists of hosts that correspond to the available configured 
virtual images to spawn, restore from snapshot, run the malware analysis on and destroy.
Each of the values present in this list requires a `[NAME]` section in the configuration file (NAME being the name of the virtual host) to define
the specific parameters for that given virtual machine.

The crucial configuration options that **MUST** be define for the process to work are:

- `platform` to define the type of operating system cuckoo need to expect on the restored host, so far only `windows` is supported
- `ip` that specifies the (usually static) ip configuration of the virtual host to allow cuckoo to communicate with it and assign analysis tasks. Note that this value could
ideally be dynamically configured, but having static addressing eases attribution (which host did what).
- `snapshot` to specify which snapshot to use to restore the virtual machine from, in order to allow reproducibility in test runs.
- `interface` to define the interface that will be used to dump all network traffic from this host during analysis.

### memory.conf

The Volatility tool offers a large set of plugins for memory dump analysis. Some of them are quite slow. In volatility.conf lets you to enable or disable the plugins of your choice.
In order to use Volatility there are two different requirements that are to be met:
- enable it in processing.conf (see relevant section)
- enable the `memory_dump` in the main cuckoo configuration

In the basic section the profile can be identified with the `guest_profile` tag name and the retention of the produced memory dump set with the `delete_memdump` option.
For most applications the default configuration and profiles will suffice.

### processing.conf

This files enables/disables the various processing modules that are available during the analysis to collect information, each located under the `modules/processing` directory.

## Running

A systemd service file can be defined in `/lib/systemd/system/cuckoo.service` as

```
    [Unit]
    Description=Main Cuckoo service wrapper
    After=network.target mongod.service
    
    [Service]
    User=cuckoo
    Group=cuckoo
    Restart=on-failure
    RestartSec=10s
    ExecStart=/opt/cuckoo_venv/bin/python2.7 cuckoo.py --debug
    WorkingDirectory=/opt/cuckoo
    
    [Install]
    WantedBy=multi-user.target
```

enabled by running with root privileges the command

```
systemctl enable cuckoo
```

and started with

```
systemctl start cuckoo
```

If the process starts successfully you can then consult its logs with `journalctl -u cuckoo` and verify that the line
`INFO: Waiting for analysis tasks.` is present.
