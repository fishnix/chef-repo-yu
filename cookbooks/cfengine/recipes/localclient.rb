#
# Cookbook Name:: cfengine
# Recipe:: localclient
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "yum"

yum_package "cfengine" do
  package_name "#{node[:cfengine][:cfengine_package]}"
  action [ :install, :upgrade ]
  options "--nogpgcheck"
end

directory "/var/cfengine/masterfiles" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

bash "set_localhost_policysvr" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  echo "Killing policy server in group.cf + promises.cf..."
  sed -i 's/#{node[:cfengine][:policy_server]}/localhost/' #{node[:cfengine][:masterfiles]}/inputs/dcsunix/group.cf
  sed -i 's/#{node[:cfengine][:policy_server]}/localhost/' #{node[:cfengine][:masterfiles]}/inputs/dcsunix/promises.cf
  EOH
  action :nothing
end

# standup boilerplate inputs
%w{ failsafe.cf group.cf }.each do |t|
  template "#{node[:cfengine][:inputs]}/#{t}" do
    source "#{t}.erb"
    owner "root"
    group "root"
    mode "0444"
    variables(
      :policy_server => "localhost"
    )
    notifies :run, resources(:bash => "set_localhost_policysvr")
  end
end

cookbook_file "/etc/sudoers.d/vagrant" do
  source "sudoers.d_vagrant"
  action :create_if_missing
  mode "0440"
end

misc_blackhole node[:cfengine][:policy_server_ip] do
 action :create_if_missing
end
