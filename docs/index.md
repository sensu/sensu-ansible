# Ansible Sensu [![Ansible Galaxy](https://img.shields.io/badge/galaxy-cmacrae.sensu-660198.svg?style=flat)](https://galaxy.ansible.com/cmacrae/sensu/)
An [Ansible](https://ansible.com) role that deploys a full [Sensu](https://sensuapp.org) stack, a modern, open source monitoring framework.

[![Join the chat at https://gitter.im/cmacrae/ansible-sensu](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/cmacrae/ansible-sensu?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Features
- Deploy a full [Sensu](https://sensuapp.org) stack, including RabbitMQ, Redis, and the [Uchiwa dashboard](https://uchiwa.io/#/)
- Tight integration with the Ansible inventory - deployment of monitoring checks based on inventory grouping
- Fine grained control over dynamic client configurations
- Automatic generation and dynamic deployment of SSL certs for secure communication between your clients and servers
- Highly configurable

## Supported Platforms
### Current Release

- [SmartOS - base-64 15.x.x](https://docs.joyent.com/images/smartos/base#version-15xx)
- [CentOS - 7](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS7)
- [Debian - 8 (Jessie)](https://wiki.debian.org/DebianJessie)
- [Ubuntu - 15.04 (Vivid Vervet)](http://releases.ubuntu.com/15.04/)

### Future Releases

- OpenBSD
- FreeBSD
- NetBSD

## Role Variables
All variables have sensible defaults, which can be found in `defaults/main.yml`.  
Head over to [the role variables page](role_variables.md) to review them

## Install (Ansible Galaxy)
To install this role from [Ansible Galaxy](https://galaxy.ansible.com), simpy run:  
`ansible-galaxy install cmacrae.sensu`

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
