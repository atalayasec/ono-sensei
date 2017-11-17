# ono-sensei documentation

Main repository to hold all the documentation for the ono-sensei project.

The ono-sensei project, sometimes referred to in the documentation as "the stack", is an attempt to develop an easy to use open source network protection platform.

[Quickstart](https://github.com/atalayasec/ono-sensei/wiki/Quickstart)

The idea is to leverage open source projects, such as Suricata, Cuckoo, Squid, and collate them in order to mimic commercial software functionalities. We believe that the world deserves a non commercial alternative for protecting against non-targeted attacks, such as ransomware, mass phishing, etc etc.


The project starts as an R&D project with the basic idea to automate file extraction and sandbox analysis via an open source stack, architecture documented [here](Architecture). The current status is Alpha, we look for help from the community to implement our [Roadmap](https://github.com/atalayasec/ono-sensei/wiki/Roadmap).


The project is sponsored by Atalaya Security, a no profit applied research group focused on information security: [Atalaya](https://www.linkedin.com/company/atalaya-security)


The Stack is downloadable as an ISO image from [here](https://download.atalayasec.net/atl5k-debug.iso)
Test it out: check the [5 Minutes Quickstart](https://github.com/atalayasec/ono-sensei/wiki/Quickstart)

## Requirements

This is the main repository to hold all the documentation for the ono-sensei project.
The software is provided as ISO. The stack can also be executed from sources. Source code is split into two components available [here](https://github.com/atalayasec/atl5k) and [here](https://github.com/atalayasec/inspector-cached). Both are required to run the project.

### Atl5k ###
This repository contains the management service and the system integration layer reponsible to interact with external software such as suricata, squid, redis.

### Inspector-Cached ###
Inspector Cached is an API service which communicates with the analysis tool such as Threat Intelligence providers and Sandbox


Part of the documentation requires [Pandoc](http://pandoc.org/) that can be installed,
on any Debian/Ubuntu system, by running the command:

```
sudo apt-get install pandoc
```

##### Name

The name is a tribute to the works of the great cyberpunk author [William Gibson](https://en.wikipedia.org/wiki/William_Gibson) fused with the [Sensei](https://en.wikipedia.org/wiki/Sensei) honorific term that usually denotes a teacher or someone that has
wisdom and experience. We hope the project will allow you to experience the web with the ease of an Ono-Sendai (do not interact with bad intentioned ICEs please) and the confidence of a personal Sensei.
