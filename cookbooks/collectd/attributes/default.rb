default[:collectd][:data_dir] = '/var/lib/collectd'
default[:collectd][:include_dir] = "/etc/collectd.d"
default[:collectd][:plugins] = [ "network", "perl", "rrdtool" ]