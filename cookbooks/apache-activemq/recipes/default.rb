#
# Cookbook Name:: apache-activemq
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'java'

# add user if doesn't exist already
user node[:apache_activemq][:user] do
  comment "App User"
end

# Install jdk
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"jdk" do... stuff
bash "install_activemq" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?(node[:apache_activemq][:servicemix_install]) }
  code <<-EOH
  /usr/bin/wget "#{node[:apache_activemq][:servicemix_url]}"
  /bin/tar -zxf "#{node[:apache_activemq][:servicemix_file]}"
  /bin/rm -f "#{node[:apache_activemq][:servicemix_file]}"
  chown -Rh root:root #{node[:apache_activemq][:servicemix_install]}
  EOH
end

link node[:apache_activemq][:servicemix_home] do
  to node[:apache_activemq][:servicemix_install]
  only_if { File.exists?(node[:apache_activemq][:servicemix_install]) }
end
