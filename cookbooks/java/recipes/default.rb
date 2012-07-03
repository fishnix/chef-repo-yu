#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory node[:java][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:java][:tmpdir]}/#{node[:java][:jdk_file]}" do
  source node[:java][:jdk_url]
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
  /bin/tar -zxf "#{node[:java][:tmpdir]}/#{node[:java][:jdk_file]}"
  EOH
  not_if { File.exists?("#{node[:java][:java_home]}") }
end