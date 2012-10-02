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
user node[:fuseesb][:user] do
  comment "App User"
  action :create
end


directory node[:fuseesb][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:fuseesb][:tmpdir]}/#{node[:fuseesb][:file]}" do
  source node[:fuseesb][:url]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :run, "bash[install_fuseesb]", :immediately
end

# Install fuseesb
bash "install_fuseesb" do
  user "root"
  cwd "/usr/local"
  code <<-EOH
  /bin/tar -zxf "#{node[:fuseesb][:tmpdir]}/#{node[:fuseesb][:file]}"
  chown -Rh "#{node[:fuseesb][:user]}":"#{node[:fuseesb][:user]}" "#{node[:fuseesb][:install]}"
  EOH
  not_if { File.exists?(node[:fuseesb][:install]) }
end

link node[:fuseesb][:home] do
  to node[:fuseesb][:install]
  only_if { File.exists?(node[:fuseesb][:install]) }
end


# create fuseesb subdirs
%w{ data deploy etc instances }.each do |d|
  directory "#{node[:fuseesb][:install]}/#{d}" do
    owner node[:fuseesb][:user]
    group node[:fuseesb][:user]
    only_if { File.exists?(node[:fuseesb][:install]) }
    mode "0755"
    action :create
  end
end

# # system.properties
# template "#{node[:fuseesb][:fuseesb_install]}/etc/system.properties" do
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
      :java_opts => node[:fuseesb][:java_opts],
      :instances => node[:fuseesb][:instances].keys
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