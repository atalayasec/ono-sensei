
# VirtualBox

While cuckoo sandbox supports a number of different virtualization technologies, [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox)
is the most commonly used, stable and easy to use for small to medium scale virtualization deployments.

## Installation

To install VirtualBox on Debian the following packages are needed:

- virtualbox
- virtualbox-guest-additions-iso
- linux-headers for the running kernel

If needed the `virtualbox-qt` package can be installed as well, allowing the user to run the VirtualBox graphical user interface
to configure and manage the virtual machine(s).

## Configuration

There is no further VirtualBox configuration needed, except adding the designed user, in this guide the `cuckoo` user, to the `vboxusers` UNIX group by running the

```
adduser cuckoo vboxusers
```

command with root privileges. After this step it is recommended to reboot the host to make sure that all configurations are correctly applied and that the
VirtualBox kernel modules are loaded at boot time. You can check whether this happened correctly by running the command

```
lsmod  | grep vb
```

as root and by verifying that the output looks like

```
    vboxpci                22921  0
    vboxnetadp             25540  0
    vboxnetflt             27648  0
    vboxdrv               379704  3 vboxnetadp,vboxnetflt,vboxpci
```

The names or versions of the kernel module might change in future releases of VirtualBox, but the `vbox*` naming should remain. Running the VirtualBox
interface or trying to boot a virtual machine will trigger an error if the modules are not correctly loaded or configured.

Please refer to the appropriate chapter for the next steps in configuring the guest system.

