#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

user "#{node[:jenkins][:jenkins_user]}" do
  comment "Applicatiion User"
  action :create
end

# Create dirs for jenkins
directory "#{node[:jenkins][:jenkins_base]}" do
  action :create
  owner  "#{node[:jenkins][:jenkins_user]}"
  group "#{node[:jenkins][:jenkins_user]}"
  mode "0755"
end

directory "#{node[:jenkins][:jenkins_home]}" do
  action :create
  owner  "#{node[:jenkins][:jenkins_user]}"
  group "#{node[:jenkins][:jenkins_user]}"
  mode "0755"
end

# Install jenkins war file
remote_file "#{node[:jenkins][:jenkins_base]}/jenkins.war" do
  source "#{node[:jenkins][:jenkins_url]}"
  owner "#{node[:jenkins][:jenkins_user]}"
  group "#{node[:jenkins][:jenkins_user]}"
  mode "0644"
  action :create_if_missing
end

# jenkins sysconfig
template "/etc/sysconfig/jenkins" do
    source "jenkins_sysconfig.erb"
    owner "root"
    group "root"
    mode 0444
end

# jenkins init script
template "/etc/init.d/jenkins" do
    source "jenkins_init.erb"
    owner "root"
    group "root"
    mode 0555
end

# drop custom plugins in place from remote sources
node[:jenkins][:custom_plugins].each do |p,l|
  remote_file "#{node[:jenkins][:jenkins_home]}/plugins/#{p}.hpi" do
    source "#{l}"
    owner "#{node[:jenkins][:jenkins_user]}"
    group "#{node[:jenkins][:jenkins_user]}"
    mode "0644"
    action :create_if_missing
  end
end

# configure jenkins - want to use jenkins gems to do this
# TBD