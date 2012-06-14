
package "collectd-rrdtool" do
  package_name "collectd-rrdtool"
  action [ :install, :upgrade ]
end

directory "#{node[:collectd][:rrdtool][:data_dir]}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

template "#{node[:collectd][:include_dir]}/collectd-rrdtool.conf" do
  source  "collectd-rrdtool.conf.erb"
  owner   "root"
  group   "root"
  mode    "0444"
  notifies :restart, resources(:service => "collectd"), :delayed
end