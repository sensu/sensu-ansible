# Sensu [![Ansible Galaxy](https://galaxy.ansible.com/list#/roles/3802)](https://img.shields.io/badge/galaxy-cmacrae.sensu-660198.svg)
This role deploys a full [Sensu](https://sensuapp.org) stack, a modern, open source monitoring framework.

## Features
- Deploy a full Sensu stack, including RabbitMQ, Redis, and the [Uchiwa dashboard](https://uchiwa.io/#/)
- Tight integration with the Ansible inventory - deployment of monitoring checks based on role defined in your inventory
- Automatic generation and dynamic deployment of SSL certs for secure communication between your clients and servers
- Highly configurable

## Documentation [![Documentation Status](https://readthedocs.org/projects/ansible-sensu/badge/?version=latest)](https://readthedocs.org/projects/ansible-sensu/?badge=latest)
Head over to [Read the Docs](http://ansible-sensu.rtfd.org/) for a comprehensive overview of this role and its powerful features.

## Supported Platforms
This role has been written with [SmartOS](https://smartos.org) in mind, to be deployed to [zones](https://wiki.smartos.org/display/DOC/Zones)

In this initial release [SmartOS](https://smartos.org) will be the only supported platform.
However, I am dedicating a lot of time to this role and will be adding support for all major BSD & Linux platforms.

### Current Release
- [SmartOS - base-64 15.1.0](https://docs.joyent.com/images/smartos/base#base-15.1.0)

### Future Releases
- OpenBSD
- FreeBSD
- NetBSD
- EL
- Ubuntu / Debian

## Role Variables
All variables have sensible defaults, which can be found in `defaults/main.yml`.
The current version includes the following variables:

### RabbitMQ Server Properties - [Sensu RabbitMQ documentation](https://sensuapp.org/docs/0.18/rabbitmq)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| rabbitmq\_config\_path| /opt/local/etc/rabbitmq | Path to the RabbitMQ configuration directory |
| rabbitmq\_host| "{{ groups\['rabbitmq\_servers']\[0] }}" | The hostname/IP address of the RabbitMQ node |
| rabbitmq\_port| 5671 | The transmission port for RabbitMQ communications |
| rabbitmq\_server| false | Determines whether to include the deployment of RabbitMQ |
| rabbitmq\_sensu\_user\_name| sensu | Username for authentication with the RabbitMQ vhost |
| rabbitmq\_sensu\_password| sensu | Password for authentication with the RabbitMQ vhost |
| rabbitmq\_sensu\_vhost| /sensu | Name of the RabbitMQ Sensu vhost |

### Redis Server Properties - [Sensu Redis documentation](https://sensuapp.org/docs/0.18/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| redis\_host| "{{ groups['redis_servers'][0] }}" | Hostname/IP address of the Redis node |
| redis\_server| false | Determines whether to include the deployment of Redis |
| redis_port| 6379 | The transmission port for Redis communications |

### Sensu Properties - [Sensu services documentation](https://sensuapp.org/docs/0.18/install-sensu)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| sensu\_api\_host| "{{ groups['sensu_masters'][0] }}" | Hostname/IP address of the node running the Sensu API |
| sensu\_api\_port| 4567 | Transmission port for Sensu API communications |
| sensu\_api\_ssl| "false" | Determines whether to use SSL for Sensu API communications |
| sensu\_api\_user\_name| admin | Username for authentication with the Sensu API |
| sensu\_api\_password| secret | Password for authentication with the Sensu API |
| sensu\_api\_uchiwa\_path| '' | Path to append to the Sensu API URI for Uchiwa communications |
| sensu\_api\_timeout| 5000 | Value to set for the Sensu API timeout |
| sensu\_client\_config| client.json.j2 | Jinja2 template to use for node configuration of the Sensu Client service |
| sensu\_config\_path| /opt/local/etc/sensu | Path to the Sensu configuration directory |
| sensu\_gem\_state| present | State of the Sensu gem - can be set to `latest` to keep Sensu updated |
| sensu\_plugin\_gem\_state| present | State of the Sensu Plugins gem - can be set to `latest` to keep Sensu Plugins updated |
| sensu\_group\_name| sensu | The name of the Sensu service user's primary group |
| sensu\_include\_plugins| true | Determines whether to include the `sensu-plugins` gem |
| sensu\_include\_dashboard| false | Determines whether to deploy the Uchiwa dashboard |
| sensu\_master| false | Determines if a node is to act as the Sensu "master" node |
| sensu\_user\_name| sensu | The name of the Sensu service user |

### Uchiwa Properties - [Uchiwa documentation](http://docs.uchiwa.io/en/latest/)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| uchiwa\_dc\_name| _undefined_ | Datacenter name for Uchiwa instance |
| uchiwa\_path| /opt/uchiwa | Path to the Uchiwa configuration directory |
| uchiwa\_redis\_use\_ssl| false | Determines whether to use SSL for Redis communication |
| uchiwa\_user\_name| admin | The user-name to log into Uchiwa |
| uchiwa\_password| admin | The password to log into Uchiwa |
| uchiwa\_port| 3000 | The TCP port to bind the Uchiwa web service to |
| uchiwa\_refresh| 5 | The interval to pull the Sensu APIs in seconds |

_Note_: _A few of these defaults will be moving to_`vars`_in the near future due to the addition of other OS support_

## Example Playbook

``` yaml
  - hosts: all
    roles:
      - role: cmacrae.sensu
```
Or, passing parameter values:

``` yaml
  - hosts: sensu_masters
    roles:
	  - { role: cmacrae.sensu, sensu_master: true, sensu_include_dashboard: true  }
```

License
-------
MIT

Author Information
------------------
Created by [Calum MacRae](http://cmacr.ae)

Feel free to:  
Contact me - [@calumacrae](https://twitter.com/calumacrae), [mailto:calum0macrae@gmail.com](calum0macrae@gmail.com)  
[Raise an issue](https://github.com/cmacrae/ansible-sensu/issues)  
[Contribute](https://github.com/cmacrae/ansible-sensu/pulls)  
