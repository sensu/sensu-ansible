# Testing
A small testing framework is provided with this role using [Vagrant](https://vagrantup.com/).  

To test this role locally, once you've set up Vagrant, simply `cd` to `tests` and run `vagrant up`, after which you can visit the following URLs in your browser for the associated deployments:  
- Ubuntu 15.04: `http://localhost:3000`

_Note: Right now, there is only an Ubuntu 15.04 system available in the testing framework. To test SmartOS, please simply roll out a base64 zone_  

To log in, use `admin` as both the username & password.  


As support for other operating systems/distributions is written, they will be added as options for testing.
