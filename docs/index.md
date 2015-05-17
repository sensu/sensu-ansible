# Ansible Sensu [![Ansible Galaxy](https://img.shields.io/badge/galaxy-cmacrae.sensu-660198.svg?style=flat)](https://galaxy.ansible.com/list#/roles/3802)
An [Ansible](https://ansible.com) role that deploys a full [Sensu](https://sensuapp.org) stack, a modern, open source monitoring framework.

## Features
- Deploy a full Sensu stack, including RabbitMQ, Redis, and the [Uchiwa dashboard](https://uchiwa.io/#/)
- Tight integration with the Ansible inventory - deployment of monitoring checks based on role defined in your inventory
- Fine grained control over dynamic client configurations
- Automatic generation and dynamic deployment of SSL certs for secure communication between your clients and servers
- Highly configurable

## Supported Platforms
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
Head over to [the role variables page](role_variables.md) to review them

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
[MIT](license.md)

Author Information
------------------
Created by [Calum MacRae](http://cmacr.ae)

Feel free to:  
Contact me - [@calumacrae](https://twitter.com/calumacrae), [mailto:calum0macrae@gmail.com](calum0macrae@gmail.com)  
[Raise an issue](https://github.com/cmacrae/ansible-sensu/issues)  
[Contribute](https://github.com/cmacrae/ansible-sensu/pulls)  
