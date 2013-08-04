#
# Cookbook Name:: graphite
# Recipe:: apache2
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apache2"

template "#{node[:apache2][:dir]}/conf.d/graphite.conf" do
   source "graphite_apache2.conf.erb"
   owner "root"
   group "root"
   mode "0444"
   notifies :restart, resources(:service => "apache2")
end