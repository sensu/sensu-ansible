Differing Master Environment
----------------------------
If the system you're hosting as your Sensu "master" has a differing environment to that of some or all of your client systems - perhaps due to a different operating system, or simply down to preference - you'll need to set the variable `sensu_master_config_path` for that system at the `host_vars` level to point to its configuration directory.  

Let's say my Sensu "master" is running in a SmartOS zone, but my clients are mostly Linux systems. I'd need to set the following in the "master" system's `host_vars`:
``` yaml
---
sensu_master_config_path: '/opt/local/etc/sensu'
```

This is necessary for the deployment of SSL data to the clients. When distributing the SSL data to the clients, a lookup is used to get the path to the data, which uses the above variable.  
If `sensu_master_config_path` is not defined at the "master" node's `host_vars` level, a default of `/etc/sensu` will be used.
