# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/).

## 1.2.0 2017-05-13
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

## 1.1.0 2017-04-03
### Added
- Toggle for SSL cert management

### Changed
- Updated repository URLs and versions for all platforms

### Fixed
- Fixed behaivor changed by recent versions of Ansible

## 1.0.0 2017-02-14

First tagged release, starting at 1.0.0 since the project can be considered stable at this point.
