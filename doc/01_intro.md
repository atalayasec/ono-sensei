# Introduction

The [Cuckoo Project](https://cuckoosandbox.org/) is an automated malware analysis sandbox that
manages a number of virtual (or physical) hosts on which to run a suspicious file or open a
suspicious URL and extract from its behaviour a number of interesting metrics.

Due to a recent change in the project direction the main repository for active code development
is now hosted [here](https://github.com/spender-sandbox/cuckoo-modified), while the most
up to date documentation can be found [here](https://github.com/spender-sandbox/cuckoo-modified/tree/master/docs). This
latter documentation is more updated but requires to be compiled, so from time to time a good source of
information can be the [original manual](http://docs.cuckoosandbox.org/en/latest/) that sometimes differs
from the updated documentation. This guide is an effort in integrating these two sources of information.

# Components

The cuckoo sandbox is made up of a number of components, the main ones are:

- Cuckoo
- Cuckoo API server
- Cuckoo web interface
- VirtualBox

This guide will provide information on how to download, configure and run the required components.

# Assumptions

This guide assumes that the reader is familiar with [Debian](https://www.debian.org), preferably a recent version that,
at the time of writing, is names [Jessie](https://www.debian.org/releases/), is proficient with the
[Bash](https://www.gnu.org/software/bash/) shell, the standard list of UNIX administration tools and user/groups concepts and 
with some of the most common provisioning and management tools that will be used. 
All service management will be assumed to be [systemd](https://www.freedesktop.org/wiki/Software/systemd/) based
and the various steps will create systemd service files and use systemd logic.

The cuckoo software and almost all of its components are written in the [Python](www.python.org) language, with some using
the [Django](https://www.djangoproject.com/) or [Flask](http://flask.pocoo.org/) web frameworks so a minimal knowledge
of the tools around the language, mainly the `python` commands and the various `2` and `3` versions of it, will be useful.

Due to the nature of the analysis performed a Windows 7 host with a valid license is required and the host
must be configured to have [User Access Control](https://en.wikipedia.org/wiki/User_Account_Control) completely disabled. This documentation
has been written and tested only with Windows 7 and Windows 10.

