#
# Cookbook Name:: fuse-mq
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jdk'

# add user if doesn't exist already
user node[:fuse_mq][:user] do
  comment "App User"
  action :create
end

# Install fuse_mq
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"fuse-mq" do... stuff
bash "install_fuse_mq" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?(node[:fuse_mq][:install]) }
  code <<-EOH
  /usr/bin/wget "#{node[:fuse_mq][:url]}"
  /bin/tar -zxf "#{node[:fuse_mq][:file]}"
  /bin/rm -f "#{node[:fuse_mq][:file]}"
  chown -Rh root:root #{node[:fuse_mq][:install]}
  EOH
end

link node[:fuse_mq][:home] do
  to node[:fuse_mq][:install]
  only_if { File.exists?(node[:fuse_mq][:install]) }
end


# create fuse_mq subdirs
#%w{ data deploy etc instances lock }.each do |d|
#  directory "#{node[:fuse_mq][:install]}/#{d}" do
#    owner "#{node[:fuse_mq][:user]}"
#    group "#{node[:fuse_mq][:user]}"
#    only_if { File.exists?("#{node[:fuse_mq][:install]}") }
#    mode "0755"
#    action :create
#  end
#end


# sysconfig
template "/etc/sysconfig/fuse-mq" do
    source "fuse-mq_sysconfig.erb"
    owner "root"
    group "root"
    mode "0444"
end

# init script
template "/etc/init.d/fuse-mq" do
    source "fuse-mq_init.erb"
    owner "root"
    group "root"
    mode "0555"
end