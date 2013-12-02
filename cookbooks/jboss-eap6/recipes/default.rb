#
# Cookbook Name:: jboss-eap6
# Recipe:: default
#
# Copyright 2013, Yale University
#
# All rights reserved - Do Not Redistribute
#

%w{ libjpeg-turbo jbossas-jbossweb-native jbossas-hornetq-native jbossas-appclient 
  jbossas-bundles jbossas-core jbossas-domain jbossas-modules-eap jbossas-product-eap
  jbossas-standalone jbossas-welcome-content-eap }.each do |pkg|
  yum_package pkg do
    action [ :install, :upgrade ]
    options "--nogpgcheck"
  end
end

directory node["jboss-eap6"]["jboss_deploy"] do
	owner node["jboss-eap6"]["user"]
	group node["jboss-eap6"]["user"]
	mode "0755"
	action :create
end

template "/etc/jbossas/standalone/standalone.xml" do
	source "standalone.xml.erb"
	owner node["jboss-eap6"]["user"]
	group node["jboss-eap6"]["user"]
	mode "0644"
end

template "/etc/jbossas/standalone/mgmt-users.properties" do
	source "mgmt-users.properties.erb"
	owner node["jboss-eap6"]["user"]
	group node["jboss-eap6"]["user"]
	mode "0644"
end

template "/etc/sysconfig/jbossas" do
	source "jbossas_sysconfig.erb"
	owner "root"
	group "root"
	mode "0644"
end

# deal with datasource drivers/modules
node["jboss-eap6"]["ds_subsys_drivers"].each do |name,detail|
	unless detail['builtin']
		# Create module directory
		directory "#{node["jboss-eap6"]["jboss_home"]}/modules/#{detail['destination']}" do
			owner node["jboss-eap6"]["user"]
			group node["jboss-eap6"]["user"]
			recursive true
			mode "0755"
			action :create
		end

		# Download driver
		remote_file "#{node["jboss-eap6"]["jboss_home"]}/modules/#{detail['destination']}/#{detail['driverfile']}" do
		  source detail['source']
		  action :create_if_missing
		end

		# Create module.xml
		template "#{node["jboss-eap6"]["jboss_home"]}/modules/#{detail['destination']}/module.xml" do
			source "ds_module.xml.erb"
			owner node["jboss-eap6"]["user"]
			group node["jboss-eap6"]["user"]
			mode "0644"
			variables({
	     :module_name => detail['module'],
	     :driverfile => detail['driverfile']
	  	})
		end
	end
end

