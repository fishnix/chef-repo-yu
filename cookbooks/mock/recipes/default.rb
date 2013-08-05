#
# Cookbook Name:: mock
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# Create skel dirs

skel_base = "/etc/skell/packages/buildroot.clean"

directory skel_base
	recursive true
	action :create
	owner "root"
	group "root"
	mode "0755"
end

%w{ RPMS SRPMS SPECS BUILD SOURCES }.each do |d|
	directory "#{skel_base}/#{d}"
		action :create
		owner "root"
		group "root"
		mode "0755"
	end
end

template "/etc/skep/.rpmmacros"
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

