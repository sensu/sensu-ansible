# Deployment of Handlers, Filters, and Mutators
_Note:_ _If you haven't familiarized yourself with the concept of the static data store please read_['_Dynamic check deployment'_](dynamic_checks.md)

Deployment of [handlers](https://sensuapp.org/docs/0.21/handlers), [filters](https://sensuapp.org/docs/0.18/filters), and [mutators](https://sensuapp.org/docs/0.18/mutators) is handled by leveraging templates and other data placed in the static data store.

## Static data store hierarchy with respect to handlers/filters/mutators
To deploy your handlers, filters, and mutators, you'll need to have directories named after each under a directory called 'sensu' in your static data store:
```
$ tree data/static
data/static
`-- sensu
    |-- definitions
    |   |-- check_nginx.json.j2
    |   |-- check_rabbitmq.json.j2
    |   |-- check_redis.json.j2
    |   |-- pushover.json.j2
    |   |-- pushover_handler.json.j2
    |   |-- smartos_check_cpu.json.j2
    |   |-- smartos_check_disk.json.j2
    |   `-- smartos_check_mem.json.j2
    |-- handlers
    |   `-- pushover.rb
	|-- filters
    `-- mutators
```

## How handlers, filters, and mutators are deployed
All three are deployed using Ansible's [template]() module. This allows the use of variables within your configurations, which can come in quite handy!

Let's take a look at the stuff I've got for [Pushover](https://pushover.net/).
First off, the [handler](https://sensuapp.org/docs/0.21/getting-started-with-handlers) json file `pushover_handler.json.j2`:
``` json
{
  "handlers": {
    "pushover": {
      "type": "pipe",
      "command": "{{ sensu_config_path }}/plugins/pushover.rb",
      "timeout": 10,
      "severites": ["critical"]
    }
  }
}
```
This is a simple handler definition, registering the `pushover` handler, and its properties, so that it can be used for any checks that trigger it.

[This particular handler](https://github.com/sensu/sensu-community-plugins/blob/master/handlers/notification/pushover.rb) needs a configuration file, `pushover.json.j2`:
``` json
{
        "pushover": {
                "apiurl": "https://api.pushover.net/1/messages",
                "userkey": "{{ sensu_pushover_userkey }}",
                "token": "{{ sensu_pushover_token }}"
        }
}

```
As mentioned above, you can see here how the use of variables within these definitions can come in useful.
To use this, I have `sensu_pushover_userkey` & `sensu_pushover_token` defined in the `host_var` file of my Sensu "master" node.

Not all handler's require a config file like this, but I figured I'd use this example to show how useful the templates can be.

Finally, we have the actual handler script [`pushover.rb`](https://github.com/sensu/sensu-community-plugins/blob/master/handlers/notification/pushover.rb), which resides in the `handlers` directory.  


These are all deployed when the role runs through the `tasks/plugins.yml` playbook, in particular these plays:
``` yaml
  - name: Deploy handler plugins
    copy:
      src: "{{ sensu_static_data_store }}/sensu/handlers/"
      dest: "{{ sensu_config_path }}/plugins/"
      mode: 0755
      owner: "{{ sensu_user_name }}"
      group: "{{ sensu_group_name }}"
    notify: restart sensu-client service

  - name: Deploy filter plugins
    copy:
      src: "{{ sensu_static_data_store }}/sensu/filters/"
      dest: "{{ sensu_config_path }}/plugins/"
      mode: 0755
      owner: "{{ sensu_user_name }}"
      group: "{{ sensu_group_name }}"
    notify: restart sensu-client service

  - name: Deploy mutator plugins
    copy:
      src: "{{ sensu_static_data_store }}/sensu/mutators/"
      dest: "{{ sensu_config_path }}/plugins/"
      mode: 0755
      owner: "{{ sensu_user_name }}"
      group: "{{ sensu_group_name }}"
    notify: restart sensu-client service

  - name: Deploy check/handler/filter/mutator definitions to the master
    template:
      src: "{{ sensu_static_data_store }}/sensu/definitions/{{ item }}.j2"
      dest: "{{ sensu_config_path }}/conf.d/{{ item }}"
      owner: "{{ sensu_user_name }}"
      group: "{{ sensu_group_name }}"
    when: sensu_master
    with_lines:
      - ls {{ sensu_static_data_store }}/sensu/definitions | sed 's/\.j2//'
    notify: restart sensu-api service
```
Quite straight forward and repetitive. If you skim this code, it may become clear that failures could be introduced if the source directories don't exist within your static data store. That's correct. You may have noticed that the example output `tree` shows both the `filters` & `mutators` directories are empty. It's expected that such features will be used, but if you don't wish to use filters or mutators, you still need to ensure these directories exist.
