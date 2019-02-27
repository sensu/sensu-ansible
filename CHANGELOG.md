# Change Log
All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/)
The format is based on [Keep a Changelog](http://keepachangelog.com/).

## [Unreleased]
- Add `client_templates` option for group based tempaltes (@michaelpporter)
- Add `run_once: true` to `delegate_to: localhost` (@michaelpporter)

## [5.0.0] - 2019-02-19
### Breaking Changes
- Prefix all variables with `sensu_` to reduce collisions with other roles (@michaelpporter)

## [4.0.0] - 2019-02-17
### Breaking Changes
- Upgrade all playbooks to `loop` syntax, requiring Ansible 2.5 or higher (@michaelpporter)
- Update role metadata to require Ansible 2.5 or higher (@jaredledvina)

### Changed
- Upgrade Inspec to 3.6.6 (@jaredledvina)
- Re-enabled Ubuntu 18.04 integration tests (@michaelpporter)
- Switch from `local_action` to `delegate_to: localhost` (@michaelpporter)

## [3.0.0] - 2019-02-16
### Breaking Changes
- Officially drop support for Ansible 2.3 (@jaredledvina)
- Switch to `include_tasks` and `import_tasks` (@michaelpporter)

### Fixed
- Update the use of tags to support Ansible 2.5 or higher (@michaelpporter)

## [2.7.0] - 2019-01-31
### Fixed
- RabbitMQ - Configure ciphers when SSL is enabled (@mkobel)
- Check if sensu_available_checks was skipped to support running in check mode (@jaredledvina)

### Changed
- Tests - Update Dockerfile and bump Inspec to 3.1.1 (@jaredledvina)
- Docs - Change theme to readthedocs from flatly to fix builds (@jaredledvina)

## [2.6.0] - 2018-07-03
### Changed
- Add support for configuring [Tessen](https://docs.sensu.io/sensu-core/1.4/reference/tessen/) via `sensu_enable_tessen` (@jaredledvina)
- Stop publishing development/testing files to Ansible Galaxy (@jaredledvina)
- Update molecule's testing configuration for speed and task profiling (@jaredledvina)
- Update Inspec to latest stable & refactor shared testing files (@jaredledvina)
- RabbitMQ - Expose a varient distro repo configs via variables for more flexibility (@jaredledvina)
- RabbitMQ - Configure apt-preferences and pin erlang to version 20.3.X (@jaredledvina)
- Fedora - RabbitMQ - Reconfigure GPG key pinning to match CentOS/AmazonLinux (@jaredledvina)
- Fedora/CentOS/AmazonLinux - Upgrade to zero-dep erlang v20 repo's (@jaredledvina)

## [2.5.0] - 2018-06-16
### Changed
- Ansible role is officially mirrored to the `sensu.sensu` namespace (@jaredledvina)
- Deprecated `sensu_pkg_version` for Redhat, Fedora, CentOS, and FreeBSD. To pin going forward across all operating systems, simply append the Sensu version to `sensu_package`. For example, `sensu_package: sensu-1.3.3` will ensure that only Sensu 1.3.3 is ever installed. (@jaredledvina)
- Ensure that on first install we install the latest stable Sensu release (@jaredledvina)
- Document `sensu_pkg_state`. If you'd like to ensure the latest stable release is always installed, simply leave `sensu_package` to the default `sensu` and change `sensu_pkg_state` to `latest`. (@jaredledvina)
- Switched entirely to [molecule](https://github.com/metacloud/molecule) for integration testing (@jaredledvina)
- Configure [Inspec](https://www.inspec.io/) for full automated verification after integration testing (@jaredledvina)
- Amazon Linux now installs proper version of EPEL (@jaredledvina)
- Amazon Linux now installs a supported version of Erlang and RabbitMQ from Bintray (@jaredledvina)
- Fixup the CentOS RabbitMQ install w/ full GPG signing verification (@jaredledvina)
- Various syntax cleanups and testing documentation updates (@jaredledvina)
- Enable `yamllint` checking and fixup all files to pass checks (@jaredledvina)
- Enable `ansible-lint` checking and fixup all errors to pass checks (@jaredledvina)
- Various doc cleanup and fixes (@jaredledvina)
- Switch openssl to `present` as `installed` is deprecated (@rlizana)


## [2.4.0] - 2018-05-06
### Fixed:
- Automated SSL key & cert generation fails on systems with Python 2.6 or older (@jaredledvina)

### Changed
- Port over the latest ssl_tools code to more native Ansible `command` instructions for greater flexibility (@jaredledvina)

## [2.3.0] - 2018-05-04
### Fixed
- Issue that prevented older OS such as CentOS 5 from installing the Sensu RPM package as they are unsigned (@smbambling)
- Security issue with redis.json being world readable, as it can contain sensitive information (@smbambling)
- Issue with conf.d that limited access and prevent automated tests from passing (@smbambling)

### Added
- Support for keepalive attributes: handlers and thresholds (warning/critical) in client.json (@smbambling)
- Support for managing safe_mode in client.json (@smbambling)

## [2.2.0] - 2018-02-22
### Added
- Fedora support. Tested in the wild on Fedora 25 as a client and Fedora 27 on the test suite as both master and client. (@danragnar)
    - `tasks/Fedora/redis.yml`, `tasks/Fedora/rabbit.yml`: Based on CentOS equivalents but with dnf module instead of yum
    - `tasks/Fedora/main.yml`, `tasks/Fedora/dashboard.yml`: links to Centos files
    - `vars/Fedora.yml`: vars for Fedora

### Changed
- `tasks/CentOS/dashboard.yml`, `tasks/CentOS/main.yml`: Use generic package module to support Fedora (@danragnar)

## [2.1.0]
### Fixed
- `defaults/main.yaml`,`tasks/plugins.yml`: Fix Python 3.X compatability issue when checking the contents of sensu_remote_plugins. (@danragnar)

### Added
- `templates/sensu-api-json.j2`, `templates/uchiwa_config.json.j2`: Check for explicitly defining sensu_uchiwa_users and sensu_api_user_name as empty to disable authentication, useful when having a reverse proxy handling auth in front of the API and/or the uchiwa dashboard (@danragnar)
- `tasks/rabbit.yml`: Consistency of remote_src option for rabbitmq and sensu when copying SSL cert/key files. Useful if certificates are generated by another CA (e.g. FreeIPA) on the sensu host. (@danragnar)

## [2.0.0] - 2018-02-07
### Breaking Change
- Split up the variables used to determine if a host gets rabbitmq/redis for more flexibility in deployments. (@tculp) `sensu_deploy_rabbitmq` and `sensu_deploy_redis` are now `sensu_deploy_rabbitmq_server` and `sensu_deploy_redis_server` respectively.  See the [role variable documentation](https://github.com/sensu/sensu-ansible/blob/master/docs/role_variables.md) for details on the parameters.
- Redis on Ubuntu will now be configured to bind to `0.0.0.0` to ensure accessiblity and to match the other supported OS configurations. (@tculp)
- Updated the supported Ansible version to the last two stable releases (currently that's Ansible 2.3 and 2.4). (@jaredledvina) Please note that we have not explicitly broken support for running this role on versions of Ansible <2.3. However, we will only be actively supporting the last two stable Ansible releases to reduce the maintenance burden.

### Added
- Initial support for OpenBSD! (@smbambling)
- Ubuntu now get's `apt-transport-https` installed to support HTTPS repos. (@kevit)
- Default to HTTPS APT repos.  @jaredledvina
- Allow for configuring when a node gets the `sensu-client` config file. (@tculp)
- Allow for deploying client definitions based on groups. (@tculp)
- Default to HTTPS Yum repo's and install the Yum key for package signing validation via HTTPS.  (@jaredledvina)
- Used HTTPS for APT key.  (@jaredledvina)
- Amazon Linux has proper yum repo configured and supports Amazon Linux 2. (@romainrbr)
- Yum based distros now get EPEL to support installing a newer and supported version of RabbitMQ. (@romainrbr)
- CentOS now supports using Bintray mirrors for installing RabbitMQ to work around Erlang issues with older versions. (@romainrbr)
- All PRs are now required to pass TravisCI integrations tests.  (@jaredledvina)
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

[Unreleased]: https://github.com/sensu/sensu-ansible/compare/5.0.0...HEAD
[5.0.0]: https://github.com/sensu/sensu-ansible/compare/4.0.0...5.0.0
[4.0.0]: https://github.com/sensu/sensu-ansible/compare/3.0.0...4.0.0
[3.0.0]: https://github.com/sensu/sensu-ansible/compare/2.7.0...3.0.0
[2.7.0]: https://github.com/sensu/sensu-ansible/compare/2.6.0...2.7.0
[2.6.0]: https://github.com/sensu/sensu-ansible/compare/2.5.0...2.6.0
[2.5.0]: https://github.com/sensu/sensu-ansible/compare/2.4.0...2.5.0
[2.4.0]: https://github.com/sensu/sensu-ansible/compare/2.3.0...2.4.0
[2.3.0]: https://github.com/sensu/sensu-ansible/compare/2.2.0...2.3.0
[2.2.0]: https://github.com/sensu/sensu-ansible/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/sensu/sensu-ansible/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/sensu/sensu-ansible/compare/1.2.0...2.0.0
[1.2.0]: https://github.com/sensu/sensu-ansible/compare/1.1.0...1.2.0
[1.1.0]: https://github.com/sensu/sensu-ansible/compare/1.0.0...1.1.0
