#
# Cookbook Name:: fuse-mc
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

# add user if doesn't exist already
user "#{node[:fusemc][:user]}" do
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
  chown -Rh root:root "#{node[:fusemc][:install]}"
  EOH
  not_if { File.exists?("#{node[:fusemc][:install]}") }
end

link "#{node[:fusemc][:home]}" do
  to "#{node[:fusemc][:install]}"
  only_if { File.exists?("#{node[:fusemc][:install]}") }
end


## sysconfig
#template "/etc/sysconfig/fuse-mc" do
#    source "fuse-mc_sysconfig.erb"
#    owner "root"
#    group "root"
#    mode "0444"
#end
#
## init script
#template "/etc/init.d/fuse-esb" do
#    source "fuse-esb_init.erb"
#    owner "root"
#    group "root"
#    mode "0555"
#end