# Sensu [![Ansible Galaxy](https://img.shields.io/badge/galaxy-sensu.sensu-660198.svg?style=flat)](https://galaxy.ansible.com/sensu/sensu/) [![Build Status](https://travis-ci.org/sensu/sensu-ansible.svg?branch=master)](https://travis-ci.org/sensu/sensu-ansible)

[![Join the chat at https://slack.sensu.io/](https://slack.sensu.io/badge.svg)](https://slack.sensu.io/)

This role deploys a full [Sensu](https://sensuapp.org) stack, a modern, open source monitoring framework.

## Features
- Deploy a full [Sensu](https://sensuapp.org) stack, including RabbitMQ, redis, and the [Uchiwa dashboard](https://uchiwa.io/#/)
- Full support for [Sensu Enterprise](https://sensuapp.org/enterprise)
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
- A supported version of Ansible, see [Ansible version support](#ansible-version-support) for details.
- The `dynamic_data_store` variable to be set: see [Dynamic Data Store](http://ansible-sensu.readthedocs.io/en/latest/dynamic_data/)
- If `sensu_include_plugins` is true (the default), the `static_data_store` variable needs to be set: see [Check Deployment](http://ansible-sensu.readthedocs.io/en/latest/dynamic_checks/)

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

See [Role Variables](http://ansible-sensu.readthedocs.io/en/latest/role_variables/) for a detailed list of the variables this role uses

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
      - { role: sensu.sensu, sensu_master: true, sensu_include_dashboard: true  }
```

## Ansible version support
All changes to this role are actively tested with the last two stable versions of Ansible to ensure compatibility. As such, this role
only officially supports running with the last two stable releases of Ansible, which aligns with the [Ansible support model](http://docs.ansible.com/ansible/latest/release_and_maintenance.html#release-status).


License
-------
MIT

Author Information
------------------
Originally created by [Calum MacRae](http://cmacr.ae) and supported by the [Sensu Community Ansible Maintainers](https://github.com/sensu-plugins/community/#maintained-areas)

### Contributors
See the projects [Contributors page](https://github.com/sensu/sensu-ansible/graphs/contributors)

Feel free to:
[Raise an issue](https://github.com/sensu/sensu-ansible/issues)
[Contribute](https://github.com/sensu/sensu-ansible/pulls)
