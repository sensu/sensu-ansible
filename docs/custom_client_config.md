# Custom Client Configuration
When this Ansible role deploys the Sensu client configuration - defined in `client.json` in the Sensu configuration directory, it works out [subscriptions](https://sensuapp.org/docs/0.21/clients#definition-attributes) based on group membership within the Ansible inventory.
For example, if you have a `webservers` group within your Ansible inventory, any nodes listed in that group will automatically gain a subscription to `webservers` within Sensu.
This is quite a powerful, convenient feature. It's coupled with the deployment of [checks](https://sensuapp.org/docs/0.18/checks). If you add a new webserver to your infrastructure, Sensu will dynamically pick it up, subscribe it to 'webservers', and deploy webserver checks, without you having to do anything other than add that node into the `webservers` group within your Ansible inventory. Instantaneous monitoring of your web services!

The above is all very nice and fancy, but, what if you want to define some other properties for a specific node, or override its subscriptions altogether?

Well, I've added the ability to define the client template to deploy with the use of a variable. This means you can deploy a specific client configuration for a single node, or a group, or really whatever you want. A nice property of this is that it's still a Jinja2 template (if you want it to be), so you can still include dynamic data whilst making your desired modifications.

## Setting a custom client configuration for a single node
Setting a custom client configuration is done using the `sensu_client_config` variable.
By default, this is set to `client.json.j2`, which resides within the `templates` directory of this role.

It's contents (as of writing) are as follows:
``` jinja2
{
  "client": {
    "name": "{{ ansible_hostname }}",
    "address": "{{ ansible_default_ipv4['address'] }}",
      "subscriptions": {{ group_names | to_nice_json }}
  }
}
```
As you can see from above, this configuration's values are all populated using [facts](http://docs.ansible.com/playbooks_variables.html#information-discovered-from-systems-facts).

To override this for a single node, this can be set in the `host_vars/node_name.domain.name.yml` file.

Let's say we have a node, called `custom.cmacr.ae`, that we'd like to set the `subscriptions` value for.
We could drop a template somewhere into our Ansible codebase called `custom_sensu.client.json.j2` then populate like so:
``` jinja2
{
  "client": {
    "name": "{{ ansible_hostname }}",
    "address": "{{ ansible_default_ipv4['address'] }}",
      "subscriptions": [
	    "production",
	    "custom"
      ]
  }
}
```

Then we would need to set the `sensu_client_config` variable for `custom.cmacr.ae` in `host_vars/custom.cmacr.ae.yml`:
``` yaml
sensu_client_config: path/to/custom_sensu.client.json.j2
```
This would override this particular node's value(s) for the `subscriptions` field, therefore changing what monitoring streams it subscribes to.


## Setting a custom client configuration for a group
Setting a custom client configuration for a group of nodes is done just the same as a single node instance, just using something like `group_vars/group_name.yml` instead of `host_vars/node.domain.name.yml`

Alright, we've got some servers that we don't want to bother all that much in a group called `thelazyones`.
Let's set their `keepalive` value to a higher value than usual (20 seconds).
An easy and logical way of approaching this would be to set `group_vars/thelazyones.yml` like so:
``` yaml
sensu_client_config: path/to/lazy_sensu.client.json.j2
```
Where `path/to/lazy_sensu.client.json.j2` is a Jinja2 template setting the `keepalive` value to something greater than usual.
