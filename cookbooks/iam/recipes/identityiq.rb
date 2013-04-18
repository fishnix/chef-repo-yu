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