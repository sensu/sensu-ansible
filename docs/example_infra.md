# Example Infrastructure Layout

This document showcases an example layout for use with the Sensu role within your infrastructure.  
It ties in with use of inventory grouping and variables.

## Inventory & Variables

### Sensu/Uchiwa variables
Let's start with an example Ansible Inventory:

``` ini
[rabbitmq_servers]
test.cmacr.ae

[redis_servers]
redis.cmacr.ae

[sensu_masters]
sensu.cmacr.ae

[webservers]
blog.cmacr.ae
web.cmacr.ae
sab.cmacr.ae
tater.cmacr.ae
beardy.cmacr.ae
pkgsrc.cmacr.ae

[zones]
ansible.cmacr.ae
beardy.cmacr.ae
blog.cmacr.ae
bunny.cmacr.ae
git.cmacr.ae
irc.cmacr.ae
pkgsrc.cmacr.ae
redis.cmacr.ae
sab.cmacr.ae
sensu.cmacr.ae
tater.cmacr.ae
web.cmacr.ae
test.cmacr.ae
```

Here we have some nodes grouped into `rabbitmq_servers`, `redis_servers`, `sensu_masters`, `webservers`, and `zones`.

Since we only want one Sensu "master", the default to act as a master in this role is set to `false` - defined by `sensu_master`.

There are several ways to approach setting `sensu_master` to `true` for the node you'd like to act as the Sensu "master".  
Personally, I do this by setting the following in `group_vars/sensu_masters.yml`:
``` yaml
sensu_master: true
sensu_include_dashboard: true
```
You can see I decided I want the Uchiwa dashboard to be deployed also, so I set `sensu_include_dashboard` to `true`.

The above code could also be set straight in the node's `host_vars` file: `host_vars/sensu.cmacr.ae.yml` or set straight in a playbook intended just for the `sensu_masters` node:
``` yaml
  - hosts: sensu_masters

    vars:
	  sensu_master: true
	  sensu_include_dashboard: true

    roles:
	  - cmacrae.sensu
```

### RabbitMQ/Redis variables
You'll probably have noticed the two groups `rabbitmq_servers` and `redis_servers` in the example inventory.
Quite self explanatory what these are, but - as with the `sensu_master` variable in the previous section - both the `rabbitmq_server` & `redis_server` values are set to `false` by default (defined in `defaults/main.yml`).

The same approach of setting these to `true` is taken here again.
Once more, I opt to set these in `group_vars`, like so:

`group_vars/rabbitmq_servers.yml`
``` yaml
rabbitmq_server: true
```

`group_vars/redis_servers.yml`
``` yaml
redis_server: true
```

The same can, again, be set directly in your RabbitMQ/Redis nodes' `host_vars` files, or done so in the playbook as shown in the previous section for the values `sensu_master` & `sensu_include_uchiwa`.
