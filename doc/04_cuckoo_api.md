
# Cuckoo API Server

The cuckoo API server is a small [Bottle](https://bottlepy.org/docs/dev/) application that runs on the same
system the main server is on and exposes a subset of the full interface that is available on the main Cuckoo
web application. There is currently no _strict_ need for the API server, but it's very useful for small monitoring
scripts and automation tasks.

## Requirements

All requirements are already satisfied by the `requirements.txt` list file in the main cuckoo project folder, so running
the application should be straightforward.

## Configuration

The API configuration file resides in `conf/api.conf` in the main cuckoo installation directory and is auto-loaded
from the Bottle executable when running. The API configuration file is commented and self-explanatory, the most important
configuration that **MUST** be set in order for the API to work is the `url` value under the `api` section that must point
to the FQDN of the cuckoo web interface (refer to the appropriate chapter for configuration).

The configuration file specifies a number of named sections, identified by the `[name]` notation, that configure how the single
route (or API resource) behaves. Various configuration options are available for each specific endpoint, the most common
ones that are usually useful to configure are:
- enabled: a `yes` or `no` value that handles whether that particular resource is available
- status: a `yes` or `no` value to enable a callback URL from the main page
- rps: a value in the LIMIT/s format, where LIMIT is the maximum number of requests per second this endpoint can satisfy. Note that
this limit applies to *all* clients.
- rpm: a value in the LIMIT/m format, where LIMIT is the maximum number of requests per minute this endpoint can satisfy. Note that
this limit applies to all clients.

## Running

The process is usually best managed with a dedicated systemd service, defined in `/lib/systemd/system/cuckoo-api.service`,
with the following content:

```
    [Unit]
    Description=Cuckoo API service wrapper
    After=network.target mongod.service cuckoo.service
    Wants=cuckoo.service
    
    [Service]
    User=cuckoo
    Group=cuckoo
    Restart=on-failure
    RestartSec=10s
    ExecStart=/opt/cuckoo_venv/bin/python2.7 utils/api.py
    WorkingDirectory=/opt/cuckoo
    
    [Install]
    WantedBy=multi-user.target
```

Note that this service lists, in the `After` section of the service file, the `cuckoo.service` dependency and requires it
to be started in the `Wants` section.

The API service can be enabled by running with root privileges the command

```
systemctl enable cuckoo-api
```

and started with

```
systemctl start cuckoo-api
```

If the process starts successfully you can then consult its logs with `journalctl -u cuckoo-api`, a series of lines like
```
Bottle <VERSION> server starting up (using WSGIRefServer())...
Listening on http://localhost:<PORT>/
Hit Ctrl-C to quit.
```
where VERSION is the current Bottle version that is installed (v0.12.9 being the latest at time of writing) and PORT is the
default port the API is listening on.

## API Documentation

Due to the active development state of the API server some of its features might change without notice, please consult the
the page at `https://github.com/spender-sandbox/cuckoo-modified/blob/master/docs/book/src/usage/api.rst` for the
latest documentation.
