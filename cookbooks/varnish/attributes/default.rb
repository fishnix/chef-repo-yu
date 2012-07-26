default[:varnish][:backend_host] = "127.0.0.1"
default[:varnish][:backend_port] = "80"
default[:varnish][:admin_host]  = "127.0.0.1"
default[:varnish][:admin_port]  = "6082"
default[:varnish][:listen_host] = ""
default[:varnish][:listen_port] = "6081"
default[:varnish][:major_vers]  = 3
default[:varnish][:pid_file]    = "/var/run/varnish.pid"
default[:varnish][:init]        = "/etc/init.d/varnish"

# This _should_ be generated with an LWRP
default[:varnish][:secret]      = "SomeSecret"
