#
# Cookbook Name:: mysql-server
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "mysql-server" do
  package_name "mysql-server"
  action [ :install, :upgrade ]
end

service "mysqld" do 
  service_name "mysqld"
  action :enable
  supports :status => true, :restart => true, :stop => true, :start => true
end

template "/etc/my.cnf" do
    source  "my.cnf.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "mysqld"), :delayed
end
