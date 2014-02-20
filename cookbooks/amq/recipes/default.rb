#
# Cookbook Name:: amq
# Recipe:: default
#
# Copyright 2013, Yale University
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'jdk'

# add user if doesn't exist already
user node[:amq][:user] do
  comment "App User"
end

#Install packages from a yum repo
package "jboss-a-mq" do
	action [:install,:upgrade]
end

%w{ users.properties system.properties }.each do |p|
  template "#{node[:amq][:home]}/etc/#{p}" do
    source "#{p}.erb"
    owner node[:amq][:user]
    group "root"
    mode 00644
  end
end

# init script
template "/etc/init.d/jboss-a-mq" do
   source "jboss-a-mq_init.erb"
   owner "root"
   group "root"
   mode "0555"
end

# sysconfig
template "/etc/sysconfig/jboss-a-mq" do
   source "jboss-a-mq_sysconfig.erb"
   owner "root"
   group "root"
   mode "0444"
end

directory node[:amq][:home] do
  owner node[:amq][:user]
  group "root"
  mode "0755"
  action :create
end

home_dirs = %w{ data data/tmp deploy etc }
home_dirs.each do |d|
  directory "#{node[:amq][:home]}/#{d}" do
    owner node[:amq][:user]
    group "root"
    mode "0755"
    action :create
  end
end

service 'jboss-a-mq' do
  action [:enable, :start]
end
