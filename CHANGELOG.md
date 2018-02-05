# Change Log
All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/)
The format is based on [Keep a Changelog](http://keepachangelog.com/).

## [Unreleased]

## [1.3.0] - 2018-02-04
### Added
- Initial support for OpenBSD! (@smbambling)
- Ubuntu now get's `apt-transport-https` installed to support HTTPS repos. (@kevit)
- Default to HTTPS APT repo's.  @jaredledvina
- Ubuntu - Redis now always binds to `0.0.0.0` to ensure it's accessible. (@tculp)
- Allow for configuring when a node gets the `sensu-client` config file. (@tculp)
- Split up the variables used to determine if a host gets rabbitmq/redis for more flexibility in deployments. (@tculp)
- Allow for deploying client definitions based on groups. (@tculp)
- Default to HTTPS Yum repo's and install the Yum key for package signing validation via HTTPS.  (@jaredledvina)
- Used HTTPS for APT key.  (@jaredledvina)
- Amazon Linux now get's proper yum repo and supports Amazon Linux 2. (@romainrbr)
- Yum based distros now get EPEL to support installing a newer and supported version of RabbitMQ. (@romainrbr)
- CentOS now supports using Bintray mirrors for installing RabbitMQ to work around Erlang issues with older versions. (@romainrbr)
- All PR's are now required to pass TravisCI tests.  (@jaredledvina)
- Ensure that we configure the `mode` and `umask` for files to work in a more restrictive environment. (@roumano)
- Debian and Ubuntu switch to Bintray for RabbitMQ to match yum distros. (@jaredledvina)

### Changed
- Switched from Gitter to `#ansible` in the Sensu Community Slack. (@grepory)
- Bumped SSL tools version to 1.2 by default. (@marji)
- Update 'Generate SSL Certs' to support Ansible 2.4. (@tculp)

## [1.2.0] - 2017-05-13
### Added
- RedHat support
- Sensu enterprise support
  - Adds a few other minor features as well, such as the ability to toggle rabbitmq's SSL
- Uchiwa HA support

### Changed
- Rely on the existing sensu repositories to install Uchiwa
- Use the FreeBSD repository
- Update documentation to note Ubuntu 15's EOL
- Allow overriding the use of EPEL on CentOS/RedHat

### Fixed
- Make sure any local directories that are assumed to exist actually do

## [1.1.0] - 2017-04-03
### Added
- Toggle for SSL cert management

### Changed
- Updated repository URLs and versions for all platforms

### Fixed
- Fixed behaivor changed by recent versions of Ansible

## 1.0.0 - 2017-02-14

First tagged release, starting at 1.0.0 since the project can be considered stable at this point.

[Unreleased]: https://github.com/sensu/sensu-ansible/compare/1.3.0...HEAD
[1.3.0]: https://github.com/sensu/sensu-ansible/compare/1.2.0...1.3.0
[1.2.0]: https://github.com/sensu/sensu-ansible/compare/1.1.0...1.2.0
[1.1.0]: https://github.com/sensu/sensu-ansible/compare/1.0.0...1.1.0
