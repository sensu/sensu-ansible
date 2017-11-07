# Role Variables
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
| `rabbitmq_enable_ssl` | `true` | Determines whether or not to use `ssl_listener` for RabbitMQ |

### [redis Server Properties](https://sensuapp.org/docs/latest/reference/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `redis_host` | `"{{ groups['redis_servers'][0] }}"` | Hostname/IP address of the redis node |
| `redis_server` | `false` | Determines whether to include the deployment of redis |
| `redis_service_name` | redis |  The name of the redis service to enable |
| `redis_pkg_repo` | _undefined_ |  The PPA to use for installing redis from (specific to Debian flavored systems) |
| `redis_pkg_name` | redis |  The name of the redis package to install |
| `redis_pkg_state` | present | The state of the redis package (should be set to `present` or `latest`) |
| `redis_port` | 6379 | The transmission port for redis communications |
| `redis_password` | `` | Password to use for redis authentication |
| `redis_sentinels` | `[]` | List of Redis Sentinel servers to use, with each item having `host` and `port` keys. Disables Sentinel when empty/unset |
| `redis_master_name` | `` | Name of the master (replica set) to use with Redis Sentinel |

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
| `sensu_config_path` | `/etc/sensu` | Path to the Sensu configuration directory |
| `sensu_include_plugins` | `true` | Determines whether to include the `sensu-plugins` gem |
| `sensu_include_dashboard` | `false` | Determines whether to deploy the Uchiwa dashboard |
| `sensu_master` | `false` | Determines if a node is to act as the Sensu "master" node |
| `sensu_client` | `true` | Determines if a node should be given the sensu client config |
| `sensu_user_name`| sensu | The name of the Sensu service user |
| `sensu_group_name` | sensu | The name of the Sensu service user's primary group |
| `sensu_remote_plugins` | _undefined_ | A list of plugins to install via `sensu-install` (Ruby Gems) |
| `sensu_client_name` | `"{{ ansible_hostname }}"` | Sensu client identification (for display purposes) |
| `sensu_client_subscriptions` | `"{{ group_names }}"` | Sensu client subscriptions |

### Sensu/RabbitMQ SSL certificate properties
| `sensu_ssl_gen_certs` | `true` | Determines when this role generates its own SSL certs |
| `sensu_ssl_manage_cert` | `true` | Determines when this role manages deployment of the certs |
| `sensu_master_config_path` | `"{{ hostvars[groups['sensu_masters'][0]]['sensu_config_path'] }}"` | The configuration path of sensu on the first master host |
| `sensu_ssl_tool_base_path` | `"{{ dynamic_data_store }}/{{ groups['sensu_masters'][0] }}{{ sensu_master_config_path }}/ssl_generation/sensu_ssl_tool"` ||
| `sensu_ssl_deploy_remote_src` | `false` | Copy certificates from paths in the destination host, not in the controller host. Useful if certificates are managed externally and already acquired before running this role. |
| `sensu_ssl_client_cert` | `"{{ sensu_ssl_tool_base_path }}/client/cert.pem"` ||
| `sensu_ssl_client_key` | `"{{ sensu_ssl_tool_base_path }}/client/key.pem"` ||
| `sensu_ssl_server_cacert` | `"{{ sensu_ssl_tool_base_path }}/sensu_ca/cacert.pem"` ||
| `sensu_ssl_server_cert` | `"{{ sensu_ssl_tool_base_path }}/server/cert.pem"` ||
| `sensu_ssl_server_key` | `"{{ sensu_ssl_tool_base_path }}/server/key.pem"` ||

### [Uchiwa Properties](http://docs.uchiwa.io/en/latest/)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `uchiwa_dc_name` | _undefined_ | Datacenter name for Uchiwa instance |
| `uchiwa_path` | `/opt/uchiwa` | Path to the Uchiwa configuration directory |
| `uchiwa_redis_use_ssl` | `false` | Determines whether to use SSL for redis communication |
| `uchiwa_users`| [{username: admin, password: admin}] | The users to log into Uchiwa |
| `uchiwa_port` | 3000 | The TCP port to bind the Uchiwa web service to |
| `uchiwa_refresh` | 5 | The interval to pull the Sensu APIs in seconds |
| `uchiwa_sensu_api_port` | "{{ sensu_api_port }}" | Port for Uchiwa to communicate with the Sensu API. Change it if you have a load balancer/reverse proxy in front of the API servers listening on a different port than 4567. |
| `uchiwa_auth_privatekey` | None | If set, Uchiwa uses the key at this location for signing JWT token |
| `uchiwa_auth_publickey` | None | Public counterpart to the above variable |

## Ubuntu
### [redis Server Properties](https://sensuapp.org/docs/latest/reference/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `redis_pkg_name` | redis-server |  The name of the redis package to install |
| `redis_service_name` | redis-server | The name of the redis service |

### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_user_name`    | root        | The name of the Sensu service user |
| `sensu_group_name`   | root        | The name of the Sensu service user's primary group |

## Debian
### [redis Server Properties](https://sensuapp.org/docs/latest/reference/redis)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `redis_pkg_name` | redis-server | The name of the redis service |
| `redis_service_name` | redis-server | The name of the redis service |

### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_user_name`    | root        | The name of the Sensu service user |
| `sensu_group_name`   | root        | The name of the Sensu service user's primary group |

## CentOS
### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_user_name`    | root        | The name of the Sensu service user |
| `sensu_group_name`   | root        | The name of the Sensu service user's primary group |
| `centos_repository`   | epel        | The name of repository use for redis or rabbitmq packages. If it set as empty string, it's using the repository already enable on the node |


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
| `sensu_gem_state` | present | State of the Sensu gem - can be set to `latest` to keep Sensu updated |
| `sensu_plugin_gem_state` | present | State of the Sensu Plugins gem - can be set to `latest` to keep Sensu Plugins updated |

## FreeBSD
### [Sensu Properties](https://sensuapp.org/docs/latest/installation/overview)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `sensu_config_path` | `/usr/local/etc/sensu` | Path to the Sensu configuration directory |
| `sensu_pkg_version` | `0.29.0_1` | Version of Sensu to download and install |
| `sensu_pkg_download_url` | `https://sensu.global.ssl.fastly.net/freebsd/FreeBSD:{{ ansible_distribution_major_version }}:{{ ansible_architecture }}/sensu/sensu-{{ sensu_pkg_version }}.txz` | URL to download Sensu from |
| `sensu_pkg_download_path` | `/root/sensu_latest.txz` | Path to store package file to |

### [RabbitMQ Server Properties](https://sensuapp.org/docs/latest/reference/rabbitmq)
| Name               | Default Value | Description                  |
|--------------------|---------------|------------------------------|
| `rabbitmq_service_name` | `rabbitmq` | The name of the RabbitMQ service |
| `rabbitmq_config_path` | `/usr/local/etc/rabbitmq` | Path to the RabbitMQ configuration directory |

### Internal properties
## Internal settings
```yaml
__bash_path: /bin/bash
__root_group: root
```
