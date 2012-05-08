#
# Cookbook Name:: apache-servicemix
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

# add user if doesn't exist already
user "#{node[:apache_servicemix][:user]}" do
  comment "App User"
end

# Install jdk
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"jdk" do... stuff
bash "install_servicemix" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?("#{node[:apache_servicemix][:servicemix_install]}") }
  code <<-EOH
  /usr/bin/wget "#{node[:apache_servicemix][:servicemix_url]}"
  /bin/tar -zxf "#{node[:apache_servicemix][:servicemix_file]}"
  /bin/rm -f "#{node[:apache_servicemix][:servicemix_file]}"
  chown -Rh root:root #{node[:apache_servicemix][:servicemix_install]}
  EOH
end

link "#{node[:apache_servicemix][:servicemix_home]}" do
  to "#{node[:apache_servicemix][:servicemix_install]}"
  only_if { File.exists?("#{node[:apache_servicemix][:servicemix_install]}") }
end


# create servicemix subdirs
%w{ data deploy etc instances lock }.each do |d|
  directory "#{node[:apache_servicemix][:servicemix_install]}/#{d}" do
    owner "#{node[:apache_servicemix][:user]}"
    group "#{node[:apache_servicemix][:user]}"
    only_if { File.exists?("#{node[:apache_servicemix][:servicemix_install]}") }
    mode "0755"
    action :create
  end
end

# system.properties
template "#{node[:apache_servicemix][:servicemix_install]}/etc/system.properties" do
    source "system.properties.erb"
    owner "root"
    group "root"
    mode "0444"
end

# sysconfig
template "/etc/sysconfig/apache-servicemix" do
    source "apache-servicemix_sysconfig.erb"
    owner "root"
    group "root"
    mode "0444"
    variables(
      :java_opts => node[:apache_servicemix][:java_opts],
      :instances => node[:apache_servicemix][:instances].keys
    )
    #notifies :restart, resources(:service => "jboss_#{n}")
end

# init script
template "/etc/init.d/apache-servicemix" do
    source "apache-servicemix_init.erb"
    owner "root"
    group "root"
    mode "0555"
end