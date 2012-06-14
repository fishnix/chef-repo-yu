
template "#{node[:collectd][:include_dir]}/collectd-perl.conf" do
    source  "collectd-perl.conf.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "collectd"), :delayed
end