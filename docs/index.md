# Ansible Sensu [![Ansible Galaxy](https://img.shields.io/badge/galaxy-sensu.sensu-660198.svg?style=flat)](https://galaxy.ansible.com/sensu/sensu/)
An [Ansible](https://ansible.com) role that deploys a full [Sensu](https://sensuapp.org) stack, a modern, open source monitoring framework.

## Features
- Deploy a full [Sensu](https://sensu.io) stack, including RabbitMQ, redis, and the [Uchiwa dashboard](https://uchiwa.io/)
- Tight integration with the Ansible inventory - deployment of monitoring checks based on inventory grouping
- Fine grained control over dynamic client configurations
- Remote plugin deployment
- Automatic generation and dynamic deployment of self-signed SSL certs for secure communication between your clients and servers
- Highly configurable

## Batteries included, but not imposed
Along with deploying the Sensu Server, API and clients, this role can deploy a full stack: [RabbitMQ](https://www.rabbitmq.com/), [redis](https://redis.io), and the [Uchiwa dashboard](https://uchiwa.io/).
However, if you want to rely on other roles/management methods to deploy/manage these services, [it's nice and easy to integrate this role](integration/).

## Requirements
This role requires Ansible 2.5

## Supported Platforms
### Automatically tested via TravisCI

- [CentOS - 6](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS6.9)
- [CentOS - 7](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS7)
- [Debian - 8 (Jessie)](https://wiki.debian.org/DebianJessie)
- [Debian - 9 (Stretch)](https://wiki.debian.org/DebianStretch)
- [Ubuntu - 14.04 (Trusty Tahr)](http://releases.ubuntu.com/14.04/)
- [Ubuntu - 16.04 (Xenial Xerus)](http://releases.ubuntu.com/16.04/)
- [Fedora - 26](https://docs.fedoraproject.org/f26/release-notes/)
- [Fedora - 27](https://docs.fedoraproject.org/f27/release-notes/)
- [Fedora - 28](https://docs.fedoraproject.org/f28/release-notes/)
- [Amazon Linux](https://aws.amazon.com/amazon-linux-ami/)
- [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/)

### Supported manually (compatibility not always guaranteed)
- [SmartOS - base-64 15.x.x](https://docs.joyent.com/images/smartos/base#version-15xx)
- [FreeBSD - 10.3, 11.0 (64-bit only)](https://www.freebsd.org/releases/10.2R/relnotes.html)
- [OpenBSD - 6.2](https://www.openbsd.org/62.html)

## Role Variables
All variables have sensible defaults, which can be found in `defaults/main.yml`.
Head over to [the role variables page](role_variables.md) to review them

## Install (Ansible Galaxy)
To install this role from [Ansible Galaxy](https://galaxy.ansible.com), simpy run:
`ansible-galaxy install sensu.sensu`

## Example Playbook

``` yaml
  - hosts: all
    roles:
      - role: sensu.sensu
```
Or, passing parameter values:

``` yaml
  - hosts: sensu_masters
    roles:
      - role: sensu.sensu
        sensu_master: true
        sensu_include_dashboard: true 
```

License
-------
[MIT](license.md)

Author Information
------------------
Originally created by [Calum MacRae](http://cmacr.ae)
Supported by the [Sensu Community Ansible Maintainers](https://github.com/sensu-plugins/community/#maintained-areas)

### Contributors
See the projects [Contributors page](https://github.com/sensu/sensu-ansible/graphs/contributors)

Feel free to:

[Raise an issue](https://github.com/sensu/sensu-ansible/issues)

[Contribute](https://github.com/sensu/sensu-ansible/pulls)
