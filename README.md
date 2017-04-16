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
- [Ubuntu - 16.04 (Vivid Vervet)](http://releases.ubuntu.com/16.04/)
- [FreeBSD - 10.3, 11.0 (64-bit only)](https://www.freebsd.org/releases/10.2R/relnotes.html)

### Future Releases

- OpenBSD
- NetBSD

## Role Variables

See [Role Variables](http://ansible-sensu.readthedocs.io/en/latest/role_variables/) for a detailed list of the variables this role uses

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
