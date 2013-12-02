jboss-eap6 Cookbook
===================
Installs and configures JBoss EAP 6.x from Redhat

Requirements
------------
- Access to rhn or satellite with JBoss channels

e.g.
#### packages
- `libjpeg-turbo_ver` 
- `jbossas-jbossweb-native`
- `jbossas-hornetq-native`
- `jbossas-appclient`
- `jbossas-bundles`
- `jbossas-core`
- `jbossas-domain`
- `jbossas-modules-eap`
- `jbossas-product-eap`
- `jbossas-standalone`
- `jbossas-welcome-content-eap`
- `openjdk-1.7`


Attributes
----------
- jboss_user
- configuration
- jboss_deploy
- maxperm
- minheap
- maxheap
- preferIPv4Stack
- proxyname
- proxyport
- http-core-threads
- http-queue-length
- http-max-threads
- http-keepalive-time
- addtl_jv_opts

Usage
-----
#### jboss-eap6::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `jboss-eap6` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jboss-eap6]"
  ]
}
```

Contributing
------------
TODO: 

License and Authors
-------------------
Authors: camden.fisher@yale.edu
