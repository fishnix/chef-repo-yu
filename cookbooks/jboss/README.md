Description
===========

A fairly generic JBoss cookbook with some provisions for yale weirdness, 
and lack of jboss/jdk packages.  This assumes a fair amount of configuration
for the node.  It could be 'smarter' if we made a bunch of assumptions about
node names, ports, etc.

Requirements
============

Attributes
==========

- Global/per server settings for jboss
- assumes single jdk + jboss install per server
- for simplicity... easy to make these node specific
    "jboss": { "jboss_apps" }		Directory to drop jboss nodes
    "jboss": { "jboss_home" }		JBoss install directory
    "jboss": { "java_home" }		Java install directory
     "jboss": { "jboss_file" }		Name of the jboss blob we suck down
     "jboss": { "jboss_url" }		URL to the jboss blob we suck down
     "jboss": { "jdk_file" }			Name of the jdk blob we suck down
     "jboss": { "jdk_url" }			URL to the jdk blob we suck down

- Node specific settings
- This is a hash of hashes.  Each key is the node name and the values are the config values
- 'type': jboss instance type: all, default, minimal, production, standard, web
- 'node_enabled': true|false
- 'partition': name of the JBoss partition (cluster)
- 'user': user to run the node
- 'clusteraddr': multicast address for the cluster
- 'loglevel': base log level
- 'msgid': JMS message id, must be unique in the cluster
- 'port_binding': Name of the port binding (ports-default, ports-01, ports-02, ports-03 are predefined)
- 'http_port': What port to bind http (8080, 8180, 8280, 8380)
- 'https_port': What port to bind https (8440, 8441, 8442,8443)
- 'maxperm': Max permgen size
- 'maxheap': Max heap size
- 'minheap': Min heap size
- 'additional_jboss_opts': array of additional jboss options
- 'additional_java_opts': array of additional java options
`    "jboss": { "nodes"  => {`
`    													'node00' => { 'type'                    => 'all',`
`                                             'node_enabled'            => false,` 
`                                             'partition'               => 'FAKEPARTITION',`
`                                             'user'                    => 'jbossa',`
`                                             'clusteraddr'             => '224.1.4.1',`
`                                             'loglevel'                => 'INFO',`
`                                             'msgid'                   => 10,`
`                                             'port_binding'            => 'ports-default',`
`                                             'http_port'               => 8080,`
`                                             'https_port'              => 8440,`
`                                             'maxperm'                 => '128m',`
`                                             'maxheap'                 => '1024m',`
`                                             'minheap'                 => '1024m',`
`                                             'additional_jboss_opts'   => [],`
`                                             'additional_java_opts'    => []`
`    																				}`
`    													}`
`    					}`


Usage
=====

Override specific attributes in the node editor:

ex.
`    	knife node edit node_name`
`    	"normal": {`
`    		"jboss": {`
`    			"nodes": {`
`    				"node00": {`
`    					"node_enabled": "true"`
`    				},`
`    				"node01": {`
`    					"node_enabled": "true"`
`    				}`
`    			}`
`    		}`
`    	knife node show node_name -a "jboss"`
