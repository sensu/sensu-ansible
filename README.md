# Sensu [![Ansible Galaxy](https://img.shields.io/badge/galaxy-cmacrae.sensu-660198.svg?style=flat)](https://galaxy.ansible.com/cmacrae/sensu/)

[![Join the chat at https://gitter.im/cmacrae/ansible-sensu](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/cmacrae/ansible-sensu?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This role deploys a full [Sensu](https://sensuapp.org) stack, a modern, open source monitoring framework.

## Features
- Deploy a full [Sensu](https://sensuapp.org) stack, including RabbitMQ, redis, and the [Uchiwa dashboard](https://uchiwa.io/#/)
- Tight integration with the Ansible inventory - deployment of monitoring checks based on inventory grouping
- Fine grained control over dynamic client configurations
- Remote plugin deployment
- Automatic generation and dynamic deployment of SSL certs for secure communication between your clients and servers
- Highly configurable

## Batteries included, but not imposed
Along with deploying the Sensu Server, API and clients, this role can deploy a full stack: [RabbitMQ](http://www.rabbitmq.com/), [redis](http://redis.io), and the [Uchiwa dashboard](https://uchiwa.io/#/).  
However, if you want to rely on other roles/management methods to deploy/manage these services, [it's nice and easy to integrate this role](http://ansible-sensu.readthedocs.io/en/latest/integration/).

## Documentation [![Documentation](https://readthedocs.org/projects/ansible-sensu/badge/?version=latest)](http://ansible-sensu.readthedocs.io/en/latest/)
[Read the full documentation](http://ansible-sensu.readthedocs.io/en/latest/) for a comprehensive overview of this role and its powerful features.

## Requirements
This role requires:
- Ansible 2.0
- The `dynamic_data_store` variable to be set: see [Dynamic Data Store](http://ansible-sensu.readthedocs.io/en/latest/dynamic_data/)
- If `sensu_include_plugins` is true (the default), the `static_data_store` variable needs to be set: see [Check Deployment](http://ansible-sensu.readthedocs.io/en/latest/dynamic_checks/)

## Supported Platforms
### Current Release

- [SmartOS - base-64 15.x.x](https://docs.joyent.com/images/smartos/base#version-15xx)
- [CentOS - 7](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS7)
- [Amazon Linux](https://aws.amazon.com/amazon-linux-ami/) - only client side support is tested
- [Debian - 8 (Jessie)](https://wiki.debian.org/DebianJessie)
- [Ubuntu - 15.04 (Vivid Vervet)](http://releases.ubuntu.com/15.04/)
- [FreeBSD - 10.2 (64-bit only)](https://www.freebsd.org/releases/10.2R/relnotes.html)

### Future Releases

- OpenBSD
- NetBSD

## Role Variables
All variables have sensible defaults, which can be found in `defaults/main.yml`.
The current version includes the following variables:

## Defaults

### Service Deployment Options
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
|`sensu_deploy_rabbitmq` | `true`    | Determines whether or not to use this role to deploy/configure RabbitMQ |
|`sensu_deploy_redis`    | `true`    | Determines whether or not to use this role to deploy/configure redis |
_Note: The above options are intended to provide users with flexibility. This allows the use of other roles for deployment of these services._

### [RabbitMQ Server Properties](https://sensuapp.org/docs/latest/reference/rabbitmq)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `rabbitmq_config_path` | `/etc/rabbitmq` | Path to the RabbitMQ configuration directory |
| `rabbitmq_config_template` | `rabbitmq.config.j2` | The template to use for the RabbitMQ service configuration |
|` rabbitmq_host` | `"{{ groups\['rabbitmq_servers']\[0] }}"` | The hostname/IP address of the RabbitMQ node |
| `rabbitmq_port` | 5671 | The transmission port for RabbitMQ communications |
| `rabbitmq_pkg_state` | present | The state of the RabbitMQ package (should be set to `present` or `latest`) |
| `rabbitmq_server` | `false` | Determines whether to include the deployment of RabbitMQ |
| `rabbitmq_service_name` | rabbitmq-server | The name of the RabbitMQ service |
| `rabbitmq_sensu_user_name` | sensu | Username for authentication with the RabbitMQ vhost |
| `rabbitmq_sensu_password` | sensu | Password for authentication with the RabbitMQ vhost |
| `rabbitmq_sensu_vhost` | `/sensu` | Name of the RabbitMQ Sensu vhost |

### [redis Server Properties](https://sensuapp.org/docs/latest/reference/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `redis_host` | `"{{ groups['redis_servers'][0] }}"` | Hostname/IP address of the redis node |
| `redis_server` | `false` | Determines whether to include the deployment of redis |
| `redis_pkg_repo` | _undefined_ |  The PPA to use for installing redis from (specific to Debian flavored systems) |
| `redis_service_name` | redis | The name of the redis service |
| `redis_pkg_name` | redis |  The name of the redis package to install |
| `redis_pkg_state` | present | The state of the redis package (should be set to `present` or `latest`) |
| `redis_port` | 6379 | The transmission port for redis communications |

### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_api_host` | `"{{ groups['sensu_masters'][0] }}"` | Hostname/IP address of the node running the Sensu API |
| `sensu_api_port` | 4567 | Transmission port for Sensu API communications |
| `sensu_api_ssl` | "false" | Determines whether to use SSL for Sensu API communications |
| `sensu_api_user_name` | admin | Username for authentication with the Sensu API |
| `sensu_api_password` | secret | Password for authentication with the Sensu API |
| `sensu_api_uchiwa_path` | `''` | Path to append to the Sensu API URI for Uchiwa communications |
| `sensu_api_timeout` | 5000 | Value to set for the Sensu API timeout |
| `sensu_client_config` | `client.json.j2` | Jinja2 template to use for node configuration of the Sensu Client service |
| `sensu_rabbitmq_config` | `rabbitmq.json.j2` | Jinja2 template to use for RabbitMQ configuration |
| `sensu_config_path` | `/etc/sensu` | Path to the Sensu configuration directory |
| `sensu_gem_state` | present | State of the Sensu gem - can be set to `latest` to keep Sensu updated |
| `sensu_plugin_gem_state` | present | State of the Sensu Plugins gem - can be set to `latest` to keep Sensu Plugins updated |
| `sensu_group_name` | sensu | The name of the Sensu service user's primary group |
| `sensu_include_plugins` | `true` | Determines whether to include the `sensu-plugins` gem |
| `sensu_include_dashboard` | `false` | Determines whether to deploy the Uchiwa dashboard |
| `sensu_master` | `false` | Determines if a node is to act as the Sensu "master" node |
| `sensu_user_name`| sensu | The name of the Sensu service user |
| `sensu_remote_plugins` | _undefined_ | A list of plugins to install via `sensu-install` (Ruby Gems) |

### Sensu/RabbitMQ SSL certificate properties
``` yaml
sensu_ssl_gen_certs: true
sensu_master_config_path: "{{ hostvars[groups['sensu_masters'][0]]['sensu_config_path'] }}"
sensu_ssl_tool_base_path: "{{ dynamic_data_store }}/{{ groups['sensu_masters'][0] }}{{ sensu_master_config_path }}/ssl_generation/sensu_ssl_tool"
sensu_ssl_client_cert: "{{ sensu_ssl_tool_base_path }}/client/cert.pem"
sensu_ssl_client_key: "{{ sensu_ssl_tool_base_path }}/client/key.pem"
sensu_ssl_server_cacert: "{{ sensu_ssl_tool_base_path }}/sensu_ca/cacert.pem"
sensu_ssl_server_cert: "{{ sensu_ssl_tool_base_path }}/server/cert.pem"
sensu_ssl_server_key: "{{ sensu_ssl_tool_base_path }}/server/key.pem"
```

### [Uchiwa Properties](http://docs.uchiwa.io/en/latest/)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `uchiwa_dc_name` | _undefined_ | Datacenter name for Uchiwa instance |
| `uchiwa_path` | `/opt/uchiwa` | Path to the Uchiwa configuration directory |
| `uchiwa_redis_use_ssl` | `false` | Determines whether to use SSL for redis communication |
| `uchiwa_users`| [{username: admin, password: admin}] | The users to log into Uchiwa |
| `uchiwa_port` | 3000 | The TCP port to bind the Uchiwa web service to |
| `uchiwa_refresh` | 5 | The interval to pull the Sensu APIs in seconds |
| `uchiwa_pkg_download_sha256sum` | _undefined_ | The SHA256 hash sum to use for verification of the Uchiwa package being fetched (specific to Linux systems) |
| `uchiwa_pkg_download_path` | _undefined_ | The path to fetch the Uchiwa package to (specific to Linux systems) |
| `uchiwa_pkg_version` | _undefined_ | The version of the Uchiwa package to fetch (specific to Linux systems) |
| `uchiwa_pkg_download_url` | _undefined_ | The URL of the Uchiwa package to fetch (template will add .deb or .rpm - specific to Linux systems) |

## Ubuntu
### [redis Server Properties](https://sensuapp.org/docs/latest/reference/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `redis_pkg_repo`   | `'ppa:rwky/redis'` | The PPA to use for installing redis from |

### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_user_name`    | root        | The name of the Sensu service user |
| `sensu_group_name`   | root        | The name of the Sensu service user's primary group |
| `uchiwa_pkg_download_sha256sum` | _See `defaults/main.yml`_ | The SHA256 hash sum to use for verification of the Uchiwa package being fetched |
| `uchiwa_pkg_download_path` | `/root/uchiwa_latest.deb` | The path to fetch the Uchiwa package to |
| `uchiwa_pkg_version` | _See `defaults/main.yml`_ | The version of the Uchiwa package to fetch (specific to Linux systems) |
| `uchiwa_pkg_download_url`  | _See `defaults/main.yml`_ | The URL of the Uchiwa package to fetch (template will add .deb or .rpm - specific to Linux systems) |

## Debian
### [redis Server Properties](https://sensuapp.org/docs/latest/reference/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `redis_pkg_repo`   | `'ppa:rwky/redis'` | The PPA to use for installing redis from |
| `redis_service_name` | redis-server | The name of the redis service |

### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_user_name`    | root        | The name of the Sensu service user |
| `sensu_group_name`   | root        | The name of the Sensu service user's primary group |
| `uchiwa_pkg_download_sha256sum` | _See `vars/Debian.yml`_ | The SHA256 hash sum to use for verification of the Uchiwa package being fetched |
| `uchiwa_pkg_download_path` | `/root/uchiwa_latest.deb` | The path to fetch the Uchiwa package to |
| `uchiwa_pkg_version` | _See `defaults/main.yml`_ | The version of the Uchiwa package to fetch (specific to Linux systems) |
| `uchiwa_pkg_download_url`  | _See `defaults/main.yml`_ | The URL of the Uchiwa package to fetch (template will add .deb or .rpm - specific to Linux systems) |

## CentOS
### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_user_name`    | root        | The name of the Sensu service user |
| `sensu_group_name`   | root        | The name of the Sensu service user's primary group |
| `uchiwa_pkg_version` | _See `defaults/main.yml`_ | The version of the Uchiwa package to fetch (specific to Linux systems) |
| `uchiwa_pkg_download_url`  | _See `defaults/main.yml`_ | The URL of the Uchiwa package to fetch (template will add .deb or .rpm - specific to Linux systems) |

## SmartOS
### [RabbitMQ Server Properties](https://sensuapp.org/docs/latest/reference/rabbitmq)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `rabbitmq_config_path` | `/opt/local/etc/rabbitmq` | Path to the RabbitMQ configuration directory |
| `rabbitmq_service_name` | rabbitmq | The name of the RabbitMQ service |

### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_config_path` | `/opt/local/etc/sensu` | Path to the Sensu configuration directory |

## FreeBSD
### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_config_path` | `/usr/local/etc/sensu` | Path to the Sensu configuration directory |
| `sensu_pkg_version` | `0.25.3_1` | Version of Sensu to download and install |
| `sensu_pkg_download_url` | `http://sensu.global.ssl.fastly.net/freebsd/10.0/amd64/sensu-{{ sensu_pkg_version }}.txz` | URL to download Sensu from |
| `sensu_pkg_download_path` | `/root/sensu_latest.txz` | Path to store package file to |

### [RabbitMQ Server Properties](https://sensuapp.org/docs/latest/reference/rabbitmq)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `rabbitmq_service_name` | `rabbitmq` | The name of the RabbitMQ service |
| `rabbitmq_config_path` | `/usr/local/etc/rabbitmq` | Path to the RabbitMQ configuration directory |

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

### Contributors
Stephen Muth - ([@smuth4](https://github.com/smuth4))

Feel free to:  
Contact me - [@calumacrae](https://twitter.com/calumacrae), [mailto:calum0macrae@gmail.com](calum0macrae@gmail.com)  
[Raise an issue](https://github.com/cmacrae/ansible-sensu/issues)  
[Contribute](https://github.com/cmacrae/ansible-sensu/pulls)  
