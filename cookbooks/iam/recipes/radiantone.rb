#
# Cookbook Name:: iam
# Recipe:: radiantone
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jdk'

directory node[:iam][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:iam][:radiantone][:tmpdir]}/#{node[:iam][:radiantone][:rpm_file]}" do
  source node[:iam][:radiantone][:rpm_source]
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  #notifies :run, "bash[install_jboss]", :immediately
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
		source sysconfig
    owner "root"
    group "root"
    mode "0644"
	end
end