default[:apache_servicemix][:servicemix_install]   = '/usr/local/apache-servicemix-4.4.1-fuse-03-06'
default[:apache_servicemix][:servicemix_file]     = 'apache-servicemix-4.4.1-fuse-03-06.tar.gz'
default[:apache_servicemix][:servicemix_url]      = 'https://s3.amazonaws.com/chef-misc/pkg/apache-servicemix-4.4.1-fuse-03-06.tar.gz'
default[:apache_servicemix][:user]                = "appa"
default[:apache_servicemix][:servicemix_home]     = "/usr/local/apache-servicemix"

default[:apache_servicemix][:maxperm] = "128m"
default[:apache_servicemix][:maxheap] = "1024m"
default[:apache_servicemix][:minheap] = "128m"

default[:apache_servicemix][:java_opts] = []

default[:apache_servicemix][:parent_enabled] = '0'

default[:apache_servicemix][:instances] = { 'child00' => { },
                                            'child01' => { }
                                          }