default[:fuseesb][:tmpdir]   = '/tmp'

default[:fuseesb][:install]   = '/usr/local/fuse-esb-7.0.0.fuse-061'
default[:fuseesb][:file]      = 'fuse-esb-full-7.0.0.fuse-061.tar.gz'
default[:fuseesb][:url]       = 'https://s3.amazonaws.com/chef-misc/pkg/fuse-esb-full-7.0.0.fuse-061.tar.gz'
default[:fuseesb][:user]      = "appa"
default[:fuseesb][:home]      = "/usr/local/fuse-esb"
default[:fuseesb][:name]      = "localhost"

default[:fuseesb][:maxperm] = "128m"
default[:fuseesb][:maxheap] = "1024m"
default[:fuseesb][:minheap] = "128m"

default[:fuseesb][:java_opts] = []

default[:fuseesb][:parent_enabled] = '1'

default[:fuseesb][:instances] = { 
                                  }