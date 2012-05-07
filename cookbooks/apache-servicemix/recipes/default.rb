#
# Cookbook Name:: apache-servicemix
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

# Install jdk
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"jdk" do... stuff
bash "install_servicemix" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?("#{node[:apache_servicemix][:servicemix_home]}") }
  code <<-EOH
  /usr/bin/wget "#{node[:apache_servicemix][:servicemix_url]}"
  /bin/tar -zxf "#{node[:apache_servicemix][:servicemix_file]}"
  /bin/rm -f "#{node[:apache_servicemix][:servicemix_file]}"
  EOH
end

link "/usr/local/apache-servicemix" do
  to "#{node[:apache_servicemix][:servicemix_home]}"
  only_if { File.exists("#{node[:apache_servicemix][:servicemix_home]}") }
end