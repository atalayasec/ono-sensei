# The Security Stack documentation

Main repository to hold all the documentation for The Security Stack project


The Security Stack, or "The Stack", is an attempt to develop an easy to use open source network protection platform.

[Quickstart](Quickstart)

The idea is to leverage open source projects, such as Suricata, Cuckoo, Squid, and collate them in order to mimic commercial software functionalities. We believe that the world deserves a non commercial alternative for protecting against non-targeted attacks, such as ransomware, mass phishing, etc etc.


The project starts as an R&D project with the basic idea to automate file extraction and sandbox analysis via an open source stack, architecture documented [here](Architecture). The current status is Alpha, we look for help from the community to implement our [Roadmap](Roadmap).


The project is sponsored by Atalaya Security, a no profit applied research group focused on information security: [Atalaya](https://www.atalayasec.net)


The Stack is downloadable as an ISO image from [here](https://download.atalayasec.net/atl5k-debug.iso)
Test it out: check the [5 Minutes Quickstart](https://github.com/atalayasec/thesecuritystack/wiki/Quickstart)

## Requirements

This is the main repository to hold all the documentation for The Security Stack project.
The stack is provided as ISO. The stack can also be executed from sources. Source code is split into two components available [here](https://github.com/atalayasec/atl5k) and [here](https://github.com/atalayasec/inspector-cached). Both are required to run the Stack

### Atl5k ###
This repository contains the management service and the system integration layer reponsible to interact with external software such as suricata, squid, redis.

### Inspector-Cached ###
Inspector Cached is an API service which communicates with the analysis tool such as Threat Intelligence providers and Sandbox


Part of the documentation requires [Pandoc](http://pandoc.org/) that can be installed,
on any Debian/Ubuntu system, by running the command:

```
sudo apt-get install pandoc
```
