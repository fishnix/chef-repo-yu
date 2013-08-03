# memcache defaults
default[:memcached][:port] = 11211
default[:memcached][:user] = "nobody"
default[:memcached][:maxconn] = 512
default[:memcached][:cachesize] = 8
default[:memcached][:pidfile] = "/var/run/memcached/memcached.pid"