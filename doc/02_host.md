# Host

The first step is configuration of the host that runs the cuckoo sandbox and all its components.

## Hardware support

There are no special hardware requirements for the main host, it is recommended to provide at least 8+ GB
ram as some will be used by cuckoo itself and a considerable part will be used by the virtual machine(s),
so scaling the memory requirements appropriately is necessary to avoid over committing problems (leading to
low or degraded performance).

It is recommended to run on a 64bit architecture - as is the standard at the time of writing and that
can be found in almost any consumer and enterprise grade physical system - even though a 32bit architecture
is expected to work with minimal or no tweaking. 

It is also recommended some sort of hardware virtualization support builtin in the CPU to optimize
performance, like AMD's [AMD-V](https://www.amd.com/es-xl/solutions/servers/virtualization) identified by the "svm"
cpuinfo flag or Intel's [VT-X](https://www-ssl.intel.com/content/www/us/en/virtualization/virtualization-technology/intel-virtualization-technology.html)
identified by the "vmx" cpuinfo flag.

## Operating System

The sandbox requires a recent Linux distribution with systemd support. [Debian](https://www.debian.org/) is recommended
as is the platform that has been used in writing and testing the current documentation, but any
reasonably recent systemd-based distribution should be compatible. Installation and basic configuration of the operating
system is not in the scope of this documentation but there are plenty of guides available in the public domain.

### Cuckoo specific OS configuration

#### Users

The creation of a separate user to run and manage all system software is recommended, this guide will assume that a
`cuckoo` user has been created on the system. On a Debian installation this user should be part of at least the following groups:

- cuckoo
- root
- sys
- adm
- disk
- lp
- man
- dialout
- voice
- cdrom
- tape
- sudo
- audio
- operator
- video
- plugdev
- staff
- users
- netdev
- messagebus
- input
- vboxusers

The last `vboxusers` is VirtualBox-specific, please refer to the appropriate chapter for configuration instructions, and different virtualization
solutions will most certainly require specific configuration.

#### Backports

In order to facilitate management and installation of the required software the `backports` repository is recommended
as the default software versions that ship with Debian tend to sometimes be a little behind the latest versions, sometimes
leading to difficulties in finding guides and documentation. To install the backports repository please refer to
the [official documentation](https://backports.debian.org/).

#### Useful packages

- [tmux](https://tmux.github.io/): a terminal multiplexer, facilitates administration of the system
- [git](https://git-scm.com/): a VCS that is the de-facto industry standard
- [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/): a Python tool manager that creates isolated and relocatable python
virtual environments
- build-essential: a meta-package that install a C compiler and related libraries and tools
- [haveged](http://www.issihosts.com/haveged/): an entropy daemon used to replenish the entropy of a system, especially useful when running on headless systems

### Kernel configuration

A recent Linux kernel is recommended, at the time of writing the `linux-image-4.7.0-1-amd64` package, together with its `linux-headers-4.7.0-1-amd64` header package
is the latest available.
