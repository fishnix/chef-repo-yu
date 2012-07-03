#
# Cookbook Name:: cfengine
# Recipe:: localclient
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum"

yum_package "cfengine" do
  action [ :install, :upgrade ]
end

directory "/var/cfengine/masterfiles" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

# standup boilerplate inputs
%w{ failsafe.cf group.cf }.each do |t|
  template "#{node[:cfengine][:inputs]}/#{t}" do
    source "#{t}.erb"
    owner "root"
    group "root"
    mode 0444
    variables(
      :policy_server => "localhost"
    )
  end
end


bash "kill_phone_homes" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  echo "Killing policy server in group.cf + promises.cf..."
  sed -i 's/#{node[:cfengine][:policy_server]}/localhost/' #{node[:cfengine][:masterfiles]}/inputs/dcsunix/group.cf
  sed -i 's/#{node[:cfengine][:policy_server]}/localhost/' #{node[:cfengine][:masterfiles]}/inputs/dcsunix/promises.cf
  echo "Blackholing policy server..."
  /sbin/ip route add blackhole #{node[:cfengine][:policy_server_ip]}
  EOH
end