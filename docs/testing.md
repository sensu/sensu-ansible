# Testing
A small testing framework is provided with this role using [Vagrant](https://vagrantup.com/).  

To test this role locally, once you've set up Vagrant, simply `cd` to `tests` and run `vagrant up`, after which you can visit the following URLs in your browser for the associated deployments:  
- Ubuntu 15.04: `http://localhost:3000`

_Note: Right now, there is only an Ubuntu 15.04 system available in the testing framework. To test SmartOS, please simply roll out a base64 zone_  

To log in, use `admin` as both the username & password.  


As support for other operating systems/distributions is written, they will be added as options for testing.

## Caveats
It is expected that the following two handlers, triggered at the end of the test run will fail: 
- `restart sensu-server service`
- `restart sensu-api service`

Both these handlers use the `delegate_to` directive, which does not play nice with Vagrant.  
This __is__ expected to work in real deployments.
