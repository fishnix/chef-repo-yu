#
# Cookbook Name:: fuse-mc
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jdk'
include_recipe 'karaf'


# add user if doesn't exist already
user node[:fusemc][:user] do
  comment "App User"
  action :create
end


directory node[:fusemc][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:fusemc][:tmpdir]}/#{node[:fusemc][:file]}" do
  source node[:fusemc][:url]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :run, "bash[install_fusemc]", :immediately
end

# Install fusemc
bash "install_fusemc" do
  user "root"
  cwd "/usr/local"
  code <<-EOH
  /bin/tar -zxf "#{node[:fusemc][:tmpdir]}/#{node[:fusemc][:file]}"
  chown -Rh "#{node[:fusemc][:user]}":"#{node[:fusemc][:user]}" "#{node[:fusemc][:install]}"
  EOH
  not_if { File.exists?(node[:fusemc][:install]) }
end

link node[:fusemc][:home] do
  to node[:fusemc][:install]
  only_if { File.exists?(node[:fusemc][:install]) }
end

template "#{node[:fusemc][:install]}/etc/users.properties" do
  source "users.properties.erb"
  owner node[:fusemc][:user]
  group node[:fusemc][:user]
  mode 00644
end

# init script
template "/etc/init.d/fuse-mc" do
   source "fuse-mc_init.erb"
   owner "root"
   group "root"
   mode "0555"
end

# sysconfig
template "/etc/sysconfig/fuse-mc" do
   source "fuse-mc_sysconfig.erb"
   owner "root"
   group "root"
   mode "0444"
end

service 'fuse-mc' do
  action [:enable, :start]
end

if node[:fusemc][:fabric][:local_resolver] == "manualip"
  karaf_cmd "create_fabric" do 
    manual_ip node[:fusemc][:fabric][:manual_ip]
    local_resolver node[:fusemc][:fabric][:local_resolver]
    global_resolver node[:fusemc][:fabric][:global_resolver]
    action :create_fabric
  end
else
  karaf_cmd "create_fabric" do 
    action :create_fabric
  end
end

karaf_cmd "enable_management_console" do 
  action :enable_mc
end
