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

# Install fuse_esb
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"fuse-esb" do... stuff
bash "install_fuse_esb" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?("#{node[:fuse_esb][:fuse_esb_install]}") }
  code <<-EOH
  /usr/bin/wget "#{node[:fuse_esb][:fuse_esb_url]}"
  /bin/tar -zxf "#{node[:fuse_esb][:fuse_esb_file]}"
  /bin/rm -f "#{node[:fuse_esb][:fuse_esb_file]}"
  chown -Rh root:root #{node[:fuse_esb][:fuse_esb_install]}
  EOH
end

link "#{node[:fuse_esb][:fuse_esb_home]}" do
  to "#{node[:fuse_esb][:fuse_esb_install]}"
  only_if { File.exists?("#{node[:fuse_esb][:fuse_esb_install]}") }
end


# create fuse_esb subdirs
%w{ data deploy etc instances lock }.each do |d|
  directory "#{node[:fuse_esb][:fuse_esb_install]}/#{d}" do
    owner "#{node[:fuse_esb][:user]}"
    group "#{node[:fuse_esb][:user]}"
    only_if { File.exists?("#{node[:fuse_esb][:fuse_esb_install]}") }
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