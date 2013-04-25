#
# Cookbook Name:: iam
# Recipe:: radiantone
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jdk'

# required for Context builder
%w{ gtk2 xorg-x11-xauth dejavu-lgc-sans-fonts dos2unix }.each do |pkg|
  package pkg do
    action [:install,:upgrade]
  end
end

# Create the tmpdir
directory node[:iam][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# Pull down rpm package into tmpdir
remote_file "#{node[:iam][:tmpdir]}/#{node[:iam][:radiantone][:rpm_file]}" do
  source node[:iam][:radiantone][:rpm_source]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
end

# Install radiantone RPM package, notify chown if we run
package "radiantone-vds-ics" do
  source "#{node[:iam][:tmpdir]}/#{node[:iam][:radiantone][:rpm_file]}"
  only_if { File.exists?("#{node[:iam][:tmpdir]}/#{node[:iam][:radiantone][:rpm_file]}") }
  notifies :run, "bash[chown_radiantone_home]", :immediately
end

# Change ownership of radiantone home
bash "chown_radiantone_home" do
  user "root"
  cwd "/usr/local"
  code <<-EOH
    chown -Rh "#{node[:iam][:radiantone][:user]}:#{node[:iam][:radiantone][:user]}" "#{node[:iam][:radiantone][:r_home]}"
  EOH
  action :nothing
end

%w{ glassfish vds vdsControlPanel }.each do |init|
	cookbook_file "/etc/init.d/#{init}" do
		source init
    owner "root"
    group "root"
    mode "0755"
    action :create_if_missing
	end
end

%w{ glassfish vds vdsControlPanel }.each do |sysconfig|
	template "/etc/sysconfig/#{sysconfig}" do
		source "#{sysconfig}.erb"
    owner "root"
    group "root"
    mode "0644"
	end
end
