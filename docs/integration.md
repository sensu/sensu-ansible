Integration with other roles/management methods
===============================================
Although this role can deploy and manage the full Sensu stack, you can opt to use other roles to manage RabbitMQ, redis, and the Uchiwa dashboard, if you so desire.  

RabbitMQ
--------
If you'd like to use a different role/management method for RabbitMQ, the following variables are of interest:
``` yaml
sensu_deploy_rabbitmq_server: false
sensu_rabbitmq_host: < IP/DNS record of your RabbitMQ server >
sensu_rabbitmq_port: < optionally set a differing port, defaults to 5671 >
sensu_rabbitmq_sensu_user_name: < the username for interacting with RabbitMQ >
sensu_rabbitmq_sensu_password: < the password for interacting with RabbitMQ >
sensu_rabbitmq_sensu_vhost: < the RabbitMQ vhost to use, defaults to '/sensu' >
sensu_rabbitmq_config_path: < the path to the RabbitMQ configuration >

```

You'll want to ensure you have a directory named `ssl` under your `sensu_rabbitmq_config_path` with the Sensu SSL Server CACert, Cert, and Key data inside (the path to this data is defined by the following variables: `sensu_ssl_server_cacert`,  `sensu_ssl_server_cert`,  `sensu_ssl_server_key`. These are typically stored in the [dynamic data store](dynamic_data/)).

redis
-----
If you'd like to use a different role/management method for redis, the following variables are of interest:
``` yaml
sensu_deploy_redis_server: false
sensu_redis_host: < IP/DNS record of your redis server >
sensu_redis_port: < optionally set a differing port, defaults to 6379 >
```

Uchiwa dashboard
----------------
If you'd like to use a different role/management method for the Uchiwa dashboard, you can simply set `sensu_include_dashboard` to `false`.
