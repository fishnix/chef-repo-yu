#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do
  package_name "nginx"
  action [ :install, :upgrade ]
end

service "nginx" do
  supports :status => true, :restart => true, :stop => true, :start => true
end