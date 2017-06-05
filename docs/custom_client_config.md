# Custom Client Configuration
When this Ansible role deploys the Sensu client configuration - defined in `client.json` in the Sensu configuration directory, it works out [subscriptions](https://sensuapp.org/docs/latest/reference/clients#client-subscriptions) based on group membership within the Ansible inventory.
For example, if you have a `webservers` group within your Ansible inventory, any nodes listed in that group will automatically gain a subscription to `webservers` within Sensu.
This is quite a powerful, convenient feature. It's coupled with the deployment of [checks](https://sensuapp.org/docs/latest/guides/getting-started/intro-to-checks.html). If you add a new webserver to your infrastructure, Sensu will dynamically pick it up, subscribe it to 'webservers', and deploy webserver checks, without you having to do anything other than add that node into the `webservers` group within your Ansible inventory. Instantaneous monitoring of your web services!

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

To override this for a single node, `sensu_client_config` can be set in the `host_vars/node_name.domain.name.yml` file. We can also override it for entire groups in `group_vars/group_name.yml`.

Let's say we have a node, called `lazynode.cmacr.ae`, that we'd like to override the subcriptions for, and also set a `keepalive.thresholds` value.
We could drop a template somewhere into our Ansible codebase called `custom_sensu.client.json.j2` then populate like so:
``` jinja2
{
  "client": {
    "name": "{{ ansible_hostname }}",
    "address": "{{ ansible_default_ipv4['address'] }}",
    "subscriptions": [
      "lazyserver",
    ],
    "keepalive": {
      "thresholds": {
        "warning": 240,
        "critical": 480
      }
    }
  }
}
```

Then we would need to set the `sensu_client_config` variable for `lazynode.cmacr.ae` in `host_vars/lazynode.cmacr.ae.yml`:
``` yaml
sensu_client_config: path/to/custom_sensu.client.json.j2
```
This would override this particular node's value(s) for the `keepalive.thresholds` and `subscriptions` fields, extending the amount of time it takes Sensu to consider a node down due to a lack of keepalives and overriding the checks it subscribes to.
