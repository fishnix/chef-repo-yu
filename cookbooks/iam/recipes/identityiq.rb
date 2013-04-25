#
# Cookbook Name:: iam
# Recipe:: identityiq
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "jboss"
include_recipe "mysql"
include_recipe "maven"

directory node[:iam][:tmpdir] do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# mysql connection
mysql_connection_info = { :host => node[:iam][:identityiq][:dbhost], :username => 'root', :password => node[:mysql][:server_root_password] }

# create the database
mysql_database node[:iam][:identityiq][:dbname] do
 connection mysql_connection_info
 action :create
end

# create the user, grant all privelages on db
mysql_database_user node[:iam][:identityiq][:dbuser] do
 connection     mysql_connection_info
 password       node[:iam][:identityiq][:dbpass]
 database_name  node[:iam][:identityiq][:dbname]
 action [:create, :grant]
end

iiqwar = "#{node[:jboss][:jboss_apps]}/node00/webapps/identityiq.war"
directory iiqwar do
	owner node[:jboss][:nodes][:node00][:user]
	group node[:jboss][:nodes][:node00][:user]
	mode 00755
	recursive true
	action :create
end

# fetch the identityiq war file from maven repo
maven "identityiq" do
  group_id "identityiq"
  version "6.0.5"
  dest node[:iam][:tmpdir]
  packaging "war"
  action :put
  notifies :run, "bash[extract_iiq_war]", :immediately
end

# Extract the identityiq war fetched by maven
bash "extract_iiq_war" do
  user node[:jboss][:nodes][:node00][:user]
  cwd "#{node[:jboss][:jboss_apps]}/node00/webapps/identityiq.war"
  code <<-EOH
    #{node[:jdk][:java_home]}/bin/jar xf #{node[:iam][:tmpdir]}/identityiq.war
  EOH
  only_if { File.exists?("#{node[:jboss][:jboss_apps]}/node00/webapps/identityiq.war") }
end

template "#{node[:jboss][:jboss_apps]}/node00/webapps/identityiq.war/WEB-INF/classes/iiq.properties" do
	source "iiq.properties.erb"
	owner node[:jboss][:nodes][:node00][:user]
	group node[:jboss][:nodes][:node00][:user]
	mode 00644
	only_if { File.exists?("#{node[:jboss][:jboss_apps]}/node00/webapps/identityiq.war") }
end

