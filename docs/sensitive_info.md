# Sensitive Information in Version Control
The Sensu framework is a distributed one, requiring different components to communicate over the network.
Naturally, a means of authentication falls into place. This can require setting credentials to ensure secure communications are made.

You might have noticed, in this role's `defaults/main.yml` that there are a few variables you can set for password properties.
If you're keeping your Ansible configuration in version control (as you really should be) - or anywhere for that matter - you most likely don't want such information to be expressed in plain text, readable to anyone/anything that may stumble upon it.

Ansible has an excellent feature called [Vault](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html) - introduced in version 1.5.
It offers a means of encrypting various pieces of data throughout your Ansible codebase.

As mentioned already throughout this documentation: Ansible really is quite versatile, so this can be approached in quite a few ways, but here's how I would suggest encrypting the sensitive variables necessary for use with this Sensu role.

### Encrypting the various `host_vars` files
Let's say we want to set the Uchiwa username and password for the node we have acting as the dashboard for our Sensu setup.
If it were a host called `uchiwa.cmacr.ae`, we could set the following in `host_vars/uchiwa.cmacr.ae.yml`:
``` yaml
sensu_uchiwa_users:
  - username: mordecai
    password: rigby
```
Then, using `ansible-vault` we can encrypt this file: `$ ansible-vault encrypt host_vars/uchiwa.cmacr.ae.yml`

Or, if we want to set the Sensu API credentials; `host_vars/sapi.cmacr.ae.yml`:
``` yaml
sensu_api_user_name: muscleman
sensu_api_password: highfiveghost
```
Same deal with encrypting it: `$ ansible-vault encrypt host_vars/uchiwa.cmacr.ae.yml`

It'll prompt for a password to encrypt with, so make sure you remember this!

### Encrypting some other `vars` file
You don't have to set these variables directly in specific a node's variables.
These could also be defined in, say, `vars/sensitive.yml` at the top of your Ansible codebase:

``` yaml
sensu_uchiwa_users:
  - username: mordecai
    password: rigby
sensu_api_user_name: muscleman
sensu_api_password: highfiveghost
```
Next up: `$ ansible-vault encrypt vars/sensitive.yml`
Then, to ensure the variables are picked up during the play, you can add `vars/sensitive.yml` to the `vars_files` list directly in your playbook:
``` yaml
  - name: Apply the Sensu role to all nodes
    hosts: all
    vars_files:
      - /path/to/ansible_codebase/vars/sensitive.yml
```

### Editing encrypted data
Editing encrypted data is as easy as `$ ansible-vault edit path/to/data.yml`
See [the Ansible Vault page for more information](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html)
