# Remote Plugin Deployment
Deployment of remote plugins, via Ruby Gems, is exposed via the `sensu_remote_plugins` variable.  
By default this variable evaluates to `~` (null). It should be set as a YAML list, like so:  
``` yaml
sensu_remote_plugins:
  - graphite
  - process-checks
```
This will install the `graphite` and `process-checks` plugins from [sensu-plugins.io](http://sensu-plugins.io/).  

Specific versions of plugins can also be defined, as shown below:
``` yaml
sensu_remote_plugins:
  - graphite
  - process-checks:0.0.6
```

As with any Ansible variable, the `sensu_remote_plugins` list can be defined where you see fit!
