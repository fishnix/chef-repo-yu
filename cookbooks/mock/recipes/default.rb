#
# Cookbook Name:: mock
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# Create skel dirs
directory "/etc/skel/packages/buildroot.clean" do
	recursive true
	action :create
	owner "root"
	group "root"
	mode "0755"
end

%w{ RPMS SRPMS SPECS BUILD SOURCES }.each do |d|
	directory "/etc/skel/packages/buildroot.clean/#{d}" do
		action :create
		owner "root"
		group "root"
		mode "0755"
	end
end

template "/etc/skel/.rpmmacros" do
	source "skel_rpmmacros.erb"
	owner "root"
	group "root"
	mode "0644"
end

cookbook_file "/etc/profile.d/mock.sh" do
	source "profile_mock.sh"
	owner "root"
	group "root"
	mode 0755
	action :create_if_missing
end

user "mock" do
	action :create
end

%w{ mock rpm-build redhat-rpm-config }.each do |p|
	package p do
		action :install
	end
end

