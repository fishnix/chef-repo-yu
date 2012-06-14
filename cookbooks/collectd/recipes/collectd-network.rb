
template "#{node[:collectd][:include_dir]}/collectd-network.conf" do
    source  "collectd-network.conf.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "collectd"), :delayed
end