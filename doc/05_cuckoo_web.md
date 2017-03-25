
# Cuckoo WEB Interface

The cuckoo web interface is a powerful and complete interface that allows the user to view, submit and
browse the results of analysis tasks. It is a [Django](https://www.djangoproject.com/) project that resides
in the `web` sub-directory of the main cuckoo tree.

## Requirements

All project requirements should already be satisfied by running the web interface from the same virtualenv
the cuckoo main component is run from.

## Configuration

All web interface configuration files are located under the main cuckoo directory, in the `web/web/local_settings.py` file. This
file defines a number of python variables that are loaded by the Django project at startup. Some of the most useful configuration 
options are:

- MAX\_UPLOAD\_SIZE to define the maximum size, in bytes, of a binary to be submitted for analysis
- LANGUAGE\_CODE to customize the default language for the installation of the web interface
- DEBUG to enable debugging of the application. **DO NOT** enable this option when running in production mode
- ALLOWED\_HOSTS to define a list of FQDNs, ip and networks from which to accept connections. Please note that when running
the web interface behind a proxy server (like Nginx) this option will effectively only "see" the source IPs as those
of the fronting proxy host.

Please refer to the official documentation [here](https://downloads.cuckoosandbox.org/docs/usage/web.html#configuration)
and [here](https://github.com/spender-sandbox/cuckoo-modified/blob/master/docs/book/src/usage/web.rst) for further
configuration options

## Running

The project can either be run manually from the management server, by running the command

```
python manage.py runserver
```

using the python from the virtualenv in the `web` sub-directory, or can be run with an application server. Due to the
large number of available application servers and the nuances of their configuration, the choice is left for the reader.
