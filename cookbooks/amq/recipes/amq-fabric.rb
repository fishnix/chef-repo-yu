#
# Cookbook Name:: amq
# Recipe:: amq-fabric
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'jdk'
include_recipe 'karaf'

# add user if doesn't exist already
user node[:amq][:user] do
  comment "App User"
end

remote_file "#{node[:amq][:tmpdir]}/#{node[:amq][:file]}" do
  source node[:amq][:url]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :run, "bash[install_amq]", :immediately
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
    /bin/tar -zxf "#{node[:amq][:tmpdir]}/#{node[:amq][:file]}"
    chown -Rh "#{node[:amq][:user]}":"#{node[:amq][:user]}" "#{node[:amq][:install]}"
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

# init script
template "/etc/init.d/jboss-a-mq" do
   source "jboss-a-mq_init.erb"
   owner "root"
   group "root"
   mode "0555"
end

# sysconfig
template "/etc/sysconfig/jboss-a-mq" do
   source "jboss-a-mq_sysconfig.erb"
   owner "root"
   group "root"
   mode "0444"
end

service 'jboss-a-mq' do
  action [:enable, :start]
end

if node[:amq][:fabric][:local_resolver] == "manualip"
  karaf_cmd "join_fabric" do 
    manual_ip       node[:amq][:fabric][:manualip]
    local_resolver  node[:amq][:fabric][:local_resolver]
    zookeeper_url   node[:amq][:fabric][:zookeeper_url]
    container_name  node[:amq][:fabric][:container_name]
    action :join_fabric
  end
else
  karaf_cmd "join_fabric" do 
   zookeeper_url node[:amq][:fabric][:zookeeper_url]
    action :join_fabric
  end
end
