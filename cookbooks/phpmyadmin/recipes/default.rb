#
# Cookbook Name:: phpmyadmin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "phpmyadmin" do
  package_name "phpmyadmin"
  action [ :install, :upgrade ]
end

service "httpd" do
  service_name "httpd"
  action :enable
  supports :status => true, :restart => true, :stop => true, :start => true
end

template "/etc/httpd/conf.d/phpMyAdmin.conf" do
    source  "phpMyAdmin.conf.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "httpd"), :delayed
end

template "/etc/phpMyAdmin/config.inc.php" do
    source  "config.inc.php.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "httpd"), :delayed
end
