# Deploy the stack to a single node
Hopefully after a quick read of the example infrastructure document, it becomes clear that this could all be applied to one node in your infrastructure.  
If you're just wanting to test this out, or if you don't want to distribute your services for some other reason; you can simply deploy the components to a single node.

This is achieved in the exact same way, setting each of the variables listed to `true`, but for one node only.
There are, however, a couple tweaks that can be made to keep your inventory a little cleaner. That is to say; if you didn't want to define `sensu_rabbitmq_servers` or `sensu_redis_servers` to simply include one node.

This can be done with the following snippets.

## One node to rule them all
`host_vars/master.cmacr.ae.yml`
``` yaml
sensu_master: true
sensu_include_dashboard: true
sensu_rabbitmq_server: true
sensu_redis_server: true
```
This would set the node `master.cmacr.ae` to act as the Sensu, RabbitMQ, and redis server for all Sensu communications across your infrastructure.

## Statically setting the communication endpoints
In `defaults/main.yml` the following keys have the following values:
``` yaml
sensu_rabbitmq_host: "{{ groups['sensu_rabbitmq_servers'][0] }}"
sensu_redis_host: "{{ groups['sensu_redis_servers'][0] }}"
sensu_api_host: "{{ groups['sensu_masters'][0] }}"
```
This is an example of using [Ansible's awesome lookups](http://docs.ansible.com/playbooks_lookups.html).  

These are very important values, they determine the points of communication for each component of Sensu.  
If you're just deploying the stack to a single node and you've decided you'd like to leave any of the `sensu_rabbitmq_servers`/`sensu_redis_servers`/`sensu_masters` groups out of your inventory, you'll need to statically set the communication endpoints.

Where you set this is, again, up to you - Ansible really is quite versatile!
If you're deploying the Sensu client to all your nodes - as you should be ;) - it's only logical to set these values globally.
You can do so by setting them in `group_vars/all.yml`:
``` yaml
sensu_rabbitmq_host: master.cmacr.ae
sensu_redis_host: master.cmacr.ae
sensu_api_host: master.cmacr.ae
```
This will tell your entire environment that if they're looking to communicate with RabbitMQ, redis, or the Sensu API, they can talk to `master.cmacr.ae`. Of course, if you're just distributing Sensu to just the `zones` group or `some_other_group`, the same could be set in `group_vars/zones.yml`/`group_vars/some_other_group.yml`.

