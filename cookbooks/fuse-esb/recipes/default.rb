#
# Cookbook Name:: fuse-esb
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'java'

# add user if doesn't exist already
user "#{node[:fuse_esb][:user]}" do
  comment "App User"
  action :create
end


directory node[:fuse_esb][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:fuse_esb][:tmpdir]}/#{node[:fuse_esb][:file]}" do
  source node[:fuse_esb][:url]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :run, "bash[install_fuse_esb]", :immediately
end

# Install fuse_esb
bash "install_fuse_esb" do
  user "root"
  cwd "/usr/local"
  code <<-EOH
  /bin/tar -zxf "#{node[:fuse_esb][:tmpdir]}/#{node[:fuse_esb][:file]}"
  chown -Rh root:root "#{node[:fuse_esb][:install]}"
  EOH
  not_if { File.exists?("#{node[:fuse_esb][:install]}") }
end

link "#{node[:fuse_esb][:home]}" do
  to "#{node[:fuse_esb][:install]}"
  only_if { File.exists?("#{node[:fuse_esb][:install]}") }
end


# create fuse_esb subdirs
%w{ data deploy etc instances lock }.each do |d|
  directory "#{node[:fuse_esb][:install]}/#{d}" do
    owner "#{node[:fuse_esb][:user]}"
    group "#{node[:fuse_esb][:user]}"
    only_if { File.exists?("#{node[:fuse_esb][:install]}") }
    mode "0755"
    action :create
  end
end

# # system.properties
# template "#{node[:fuse_esb][:fuse_esb_install]}/etc/system.properties" do
#     source "system.properties.erb"
#     owner "root"
#     group "root"
#     mode "0444"
# end

# sysconfig
template "/etc/sysconfig/fuse-esb" do
    source "fuse-esb_sysconfig.erb"
    owner "root"
    group "root"
    mode "0444"
    variables(
      :java_opts => node[:fuse_esb][:java_opts],
      :instances => node[:fuse_esb][:instances].keys
    )
    #notifies :restart, resources(:service => "jboss_#{n}")
end

# init script
template "/etc/init.d/fuse-esb" do
    source "fuse-esb_init.erb"
    owner "root"
    group "root"
    mode "0555"
end