#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install deps
%w{ pycairo pycairo-devel Django14 django-tagging python-django-tagging python-twisted python-zope-interface4 mod_python mod_wsgi python-memcached python-sqlite2 python-storm-mysql }.each do |p|
 	package p do
 		action [:install, :upgrade]
	end
end

# Install fonts
%w{ bitmap bitmap-console-fonts bitmap-fangsongti-fonts bitmap-fixed-fonts bitmap-fonts-compat bitmap-lucida-typewriter-fonts bitmap-miscfixed-fonts }.each do |p|
 	package p do
 		action [:install, :upgrade]
	end
end

python_pip "Twisted" do
  version "12.0.0"
  action :install
end

python_pip "whisper"
python_pip "carbon"
python_pip "graphite-web"

%w{ aggregation-rules.conf carbon.conf graphite.wsgi storage-aggregation.conf 
	blacklist.conf dashboard.conf relay-rules.conf storage-schemas.conf 
	carbon.amqp.conf graphTemplates.conf rewrite-rules.conf whitelist.conf }.each do |f|
	template "#{node[:graphite][:home]}/conf/#{f}" do
	   source "#{f}.erb"
	   owner "root"
	   group "root"
	   mode "0444"
	end
end

template "#{node[:graphite][:home]}/webapp/graphite/local_settings.py" do
	source "local_settings.py.erb"
	owner "root"
	group "root"
	mode "0444"
end

mysql_connection_info = {:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']}

# create the database
mysql_database 'graphite' do
	connection mysql_connection_info
	action :create
end

# create the user, grant all privelages on db
mysql_database_user 'graphite' do
	connection mysql_connection_info
	password 'graphite123'
	database_name 'graphite'
	action [:create, :grant]
end



