
# Guest VM

When cuckoo runs a malware or analyses a possibly suspicious website a number of bad things might happen on the host
that runs the analysis itself, therefore it becomes necessary to have a reliable way of starting from a known-good
configuration for each test run, both to avoid having to reinstall or reconfigure the host each time and to ensure that
each test run is repeatable and isolated from other tests. In order to accomplish this the most most common and convenient
technique is to use a virtual machine whose state is restored from a known snapshot and then destroyed once the analysis is
complete.

## Installation

Create a virtual machine using a windows 7 installation image with User Access Control disabled, please refer to the official
VirtualBox documentation on how to create a virtual machine and to the [official Microsoft documentation](https://support.microsoft.com/en-us/help/975787/guided-help-adjust-user-account-control-settings-in-windows-7-and-windows-8)
to disable UAC on Windows.

### Python

Install Python in the virtual machine, you can refer to the [official page](https://www.python.org/getit/) to download the appropriate
installer for version 2.7+ of the language. The optional [Python Image Library](http://www.pythonware.com/products/pil/) can be installed
to take screenshots of the virtual machine screen during the analysis process.

### Windows Settings

Disable windows firewall and automatic updates, the former to avoid windows prevent connections in and out of your virtual environment
therefore polluting the test results and the latter to make sure that no unexpected traffic is generated during the analysis due to
windows trying to update itself. Please refer to official Microsoft documentation on how to do this for your Windows operating system version.

### Networking

In order to let the virtual host connect to the Internet you should make sure a repeatable and working configuration is enabled on the guest,
a static ip address is recommended so that the cuckoo stack running on the host can connect to the python agent (more on that later) running
inside the virtualized environment. Refer to the official VirtualBox documentation for setup.

### Python Agent

Cuckoo uses a tiny Python script running on the guest to run, analyse malware and fetch the results from the guest itself. The agent is located in the
root directory of the Cuckoo repository in the `agent.py` file. This file can be copied in the `Startup` folder of the windows guest to make sure it
is run each time at boot and to be already running when the guest is restored from the snapshot.

## Preparing the snapshot

Once all configuration is completed **make sure to reboot the guest and that the python agent is running correctly** and create a snapshot of the
running host. The name of this snapshot will then be the one to use in cuckoos configuration.

It is recommended to backup and store the virtual machine and its configuration in a safe place for analysis reproducibility and for easier restoration
should anything go wrong during the test/setup phase of the virtual machine itself.
