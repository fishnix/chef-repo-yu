# network plugin attributes
default[:collectd][:network][:forwards]     = 'false'
default[:collectd][:network][:report_stats] = 'true'
default[:collectd][:network][:cache_flush]  = '1800'
default[:collectd][:network][:ttl]          = '128'
default[:collectd][:network][:is_client]    = true
default[:collectd][:network][:is_server]    = false
default[:collectd][:network][:server_ip]    = "127.0.0.1"
default[:collectd][:network][:server_port]  = "25826"
