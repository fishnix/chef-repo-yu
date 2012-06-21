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
remote_file "#{node[:jenkins][:jenkins_home]}/jenkins.war" do
  source "#{node[:jenkins][:jenkins_url]}"
  owner "#{node[:jenkins][:jenkins_user]}"
  group "#{node[:jenkins][:jenkins_user]}"
  mode "0644"
  action :create_if_missing
end