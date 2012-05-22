#
# Cookbook Name:: stash
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

# add user if doesn't exist already
user "#{node[:stash][:user]}" do
  comment "App User"
end

# Install stash
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package do... stuff
bash "install_stash" do
  user "#{node[:stash][:user]}"
  cwd "#{node[:stash][:basedir]}"
  not_if { File.exists?("#{node[:stash][:stash_install]}") }
  code <<-EOH
  /usr/bin/wget "#{node[:stash][:stash_url]}"
  /bin/tar -zxf "#{node[:stash][:stash__file]}"
  /bin/rm -f "#{node[:stash][:stash_file]}"
  chown -Rh #{node[:stash][:user]}:#{node[:stash][:user]} #{node[:stash][:stash_install]}
  EOH
end

link "#{node[:stash][:stash_home]}" do
  to "#{node[:stash][:stash_install]}"
  only_if { File.exists?("#{node[:stash][:stash_install]}") }
end