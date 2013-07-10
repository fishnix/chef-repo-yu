#
# Cookbook Name:: amq
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'jdk'

# add user if doesn't exist already
user node[:amq][:user] do
  comment "App User"
end

# Install amq
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# easily swappable with package"jdk" do... stuff
bash "install_amq" do
  user "root"
  cwd "/usr/local"
  not_if { File.exists?(node[:amq][:install]) }
  code <<-EOH
    /usr/bin/wget "#{node[:amq][:url]}"
    /bin/tar -zxf "#{node[:amq][:file]}"
    /bin/rm -f "#{node[:amq][:file]}"
    chown -Rh "#{node[:amq][:user]}":root "#{node[:amq][:install]}"
  EOH
end

link node[:amq][:home] do
  to node[:amq][:install]
  only_if { File.exists?(node[:amq][:install]) }
end


%w{ users.properties system.properties }.each do |p|
  template "#{node[:amq][:home]}/etc/#{p}" do
    source "#{p}.erb"
    owner node[:amq][:user]
    group "root"
    mode 00644
  end
end

