default[:fuse_esb][:install]   = '/usr/local/fuse-esb-7.0.0.fuse-061'
default[:fuse_esb][:file]      = 'fuse-esb-full-7.0.0.fuse-061.tar.gz'
default[:fuse_esb][:url]       = 'https://s3.amazonaws.com/chef-misc/pkg/fuse-esb-full-7.0.0.fuse-061.tar.gz'
default[:fuse_esb][:user]      = "appa"
default[:fuse_esb][:home]      = "/usr/local/fuse-esb"

default[:fuse_esb][:maxperm] = "128m"
default[:fuse_esb][:maxheap] = "1024m"
default[:fuse_esb][:minheap] = "128m"

default[:fuse_esb][:java_opts] = []

default[:fuse_esb][:parent_enabled] = '1'

default[:fuse_esb][:instances] = { 
                                  }