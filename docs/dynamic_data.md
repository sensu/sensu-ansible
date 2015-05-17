# Dynamic Data Store
Throughout this role, you may notice the use of the variable `dynamic_data_store`.
This is a convention that I have implemented personally within my infrastructure, though it stems from a feature that I'm sure many people leverage in their own way - probably in a very similar manner.

## The concept
The dynamic data store is a directory on the node acting as the Ansible "master" (where you're pushing all your Ansible code from).
This directory, in version control, is practically empty, with the exception of a `.gitignore` with the following contents:
```
# Ignore everything in this directory
*
# Except this file
!.gitignore
```
Using this `.gitignore` ensures that the directory (and the `.gitignore`) are kept within version control, but anything that may be placed in it is not tracked. As you may have figured out from the name "dynamic", that's because the data here will be subject to change with your infrastructure.

The idea behind having this "empty" directory within your codebase is that, when deploying your Ansible code repo to your Ansible "master", it ensures the directory is there. This directory is then used in conjunction with some roles to store node specific data that you may wish to distribute amongst other nodes.

## Use of the dynamic data store in this Sensu role
If you take a look at the `tasks/ssl.yml` playbook, there's a use of the handy [`fetch`](http://docs.ansible.com/fetch_module.html) module.

>This module works like `copy`, but in reverse. It is used for fetching files from remote machines and storing them locally in a file tree, organized by hostname.

Very handy!

I've coupled this with the generation of SSL certs on the Sensu "master". So, when applying this role to a node on which `sensu_master` evaluates to `true`, several SSL certs are generated, then stashed on the Ansible "master" node in the dynamic data store for distribution to client nodes at a later point in the playbook.

I've defined my `dynamic_data_store` variable at the top level of my Ansible codebase, in the file `group_vars/all.yml`:
``` yaml
dynamic_data_store: /path/to/ansible/config/data/dynamic
```
Let's take a look at this directory:
```
$ tree data/dynamic
data/dynamic/
`-- sensu.cmacr.ae
    `-- opt
        `-- local
            `-- etc
                `-- sensu
                    `-- ssl_generation
                        `-- ssl_certs
                            |-- client
                            |   |-- cert.pem
                            |   `-- key.pem
                            |-- sensu_ca
                            |   `-- cacert.pem
                            `-- server
                                |-- cert.pem
                                `-- key.pem
```
As you can see, it resembles the file tree from the node it fetched the data from. This is configurable behavior, and can be set otherwise if you find this inconvenient/unsightly. See [ the `fetch` documentation](http://docs.ansible.com/fetch_module.html) for more information.

## Deployment of the data fetched to the dynamic data store
Next up is this rather unsightly play (still from the `tasks/ssl.yml` playbook):
``` yaml
  - name: Deploy the Sensu client SSL cert/key
    copy: src={{ dynamic_data_store }}/{{ groups['sensu_masters'][0] }}/{{ sensu_config_path }}/ssl_generation/ssl_certs/client/{{ item }}
          owner={{ sensu_user_name }} group={{ sensu_group_name }}
          dest={{ sensu_config_path }}/ssl
    with_items:
      - cert.pem
      - key.pem

```
Blegh! Pretty ugly, right? Well, it may not be so great looking, but it's pretty nifty.
It takes care of distributing the SSL certificates to the client systems so they can interact with the Sensu API.

The same method is used for node communication with RabbitMQ:
`tasks/rabbitmq.yml`
``` yaml
  - name: Ensure RabbitMQ SSL certs/keys are in place
    copy: src={{ dynamic_data_store }}/{{ groups['sensu_masters'][0] }}/{{ sensu_config_path }}/ssl_generation/ssl_certs/{{ item }}
          dest={{ rabbitmq_config_path }}/ssl
    with_items:
      - sensu_ca/cacert.pem
      - server/cert.pem
      - server/key.pem
```

## So, what do I need to do?
Well, you simply need to decide where, on your Ansible "master" node's filesystem, where you'd like your dynamic data store to reside.
Then simply set the `dynamic_data_store` value to that path for all nodes that are going to be using this Sensu role, as described above.

This variable's value, like any other in Ansible, can include variable(s) itself also.
I have a role that deploys an Ansible "master" node, and use a variable for where I want my Ansible codebase to sit.
So my `dynamic_data_store` (again) defined in `group_vars/all.yml` is actually set to:
``` yaml
dynamic_data_store: {{ ansible_conf_path }}/data/dynamic
```
