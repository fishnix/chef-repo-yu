
template "#{node[:collectd][:include_dir]}/collectd-rrdtool.conf" do
    source  "collectd-rrdtool.conf.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "collectd"), :delayed
end