#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install jdk
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"jdk" do... stuff
bash "install_jdk" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?("#{node[:java][:java_home]}") }
  code <<-EOH
  /usr/bin/wget "#{node[:java][:jdk_url]}"
  /bin/tar -zxf "#{node[:java][:jdk_file]}"
  /bin/rm -f "#{node[:java][:jdk_file]}"
  EOH
end