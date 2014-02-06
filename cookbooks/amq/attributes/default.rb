default[:amq][:user]	 = 'appa'
default[:amq][:home]  	 = '/usr/local/jboss-a-mq'
default[:amq][:install]  = '/usr/local/jboss-a-mq-6.0.0.redhat-024'
default[:amq][:file]     = 'jboss-a-mq-6.0.0.redhat-024.tar.gz'
default[:amq][:url]      = 'xxxx'

default[:amq][:maxperm] = "128m"
default[:amq][:maxheap] = "1024m"
default[:amq][:minheap] = "128m"

default[:amq][:fabric][:local_resolver] = 'localhostname'