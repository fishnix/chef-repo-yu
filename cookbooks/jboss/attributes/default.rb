# Global/per server settings for jboss
# assumes single jdk + jboss install per server
# for simplicity... easy to make these node specific
default[:jboss][:jboss_apps]    = '/usr/local/jboss-apps'
default[:jboss][:jboss_deploy]  = '/usr/local/jboss-deploy'
default[:jboss][:jboss_home]    = '/usr/local/jboss-eap-5.1/jboss-as'
default[:jboss][:jboss_logdir]  = "/var/log/jboss"
default[:jboss][:jboss_web_deploy] = "deploy/jbossweb.sar"

# Where should I get my jboss + jdk from? yeah, yeah, packages! I know...
default[:jboss][:jboss_file]    = 'jboss-eap-5.1.2.tar.gz'
default[:jboss][:jboss_url]     = 'https://s3.amazonaws.com/chef-misc/pkg/jboss-eap-5.1.2.tar.gz'
default[:jboss][:tmpdir]        = "/tmp"

# Node specific settings
# 'type' is the jboss instance type: all, default, minimal, production, standard, web
default[:jboss][:nodes] = { 'node00' => { 'type'                    => 'all',
                                          'node_enabled'            => false, 
                                          'partition'               => 'FAKEPARTITION',
                                          'user'                    => 'appa',
                                          'clusteraddr'             => '224.1.4.1',
                                          'loglevel'                => 'INFO',
                                          'msgid'                   => 10,
                                          'port_binding'            => 'ports-default',
                                          'http_port'               => 8080,
                                          'https_port'              => 8440,
                                          'maxperm'                 => '128m',
                                          'maxheap'                 => '1024m',
                                          'minheap'                 => '1024m',
                                          'additional_jboss_opts'   => [],
                                          'additional_java_opts'    => [] 
                                        },
                            'node01' => { 'type'                    => 'all',
                                          'node_enabled'            => false, 
                                          'partition'               => 'FAKEPARTITION',
                                          'user'                    => 'appa',
                                          'clusteraddr'             => '224.1.4.1',
                                          'loglevel'                => 'INFO',
                                          'msgid'                   => 11,
                                          'port_binding'            => 'ports-01',
                                          'http_port'               => 8180,
                                          'https_port'              => 8441,
                                          'maxperm'                 => '128m',
                                          'maxheap'                 => '1024m',
                                          'minheap'                 => '1024m',
                                          'additional_jboss_opts'   => [],
                                          'additional_java_opts'    => [] 
                                        }
                            }

