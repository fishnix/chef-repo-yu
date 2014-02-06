#
# Cookbook Name:: jdk
# Recipe:: default
#
# Copyright 2013, Yale University
#
# All rights reserved - Do Not Redistribute
#

directory node[:jdk][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:jdk][:tmpdir]}/#{node[:jdk][:jdk_file]}" do
  source node[:jdk][:jdk_url]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :run, "bash[install_jdk]", :immediately
end

# Install jdk
bash "install_jdk" do
  user "root"
  cwd "/usr/local"
  code <<-EOH
  /bin/tar -zxf "#{node[:jdk][:tmpdir]}/#{node[:jdk][:jdk_file]}"
  EOH
  not_if { File.exists?(node[:jdk][:java_home]) }
end