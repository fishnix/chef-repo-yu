#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install deps
%w{ pycairo pycairo-devel Django14 django-tagging python-django-tagging python-twisted python-zope-interface4 mod_python mod_wsgi python-memcached }.each do |p|
 	package p do
 		action [:install, :upgrade]
	end
end

# install graphite
bash "install_graphite" do
	action :run
	user "root"
	cwd "/tmp"
	code <<-EOH
	/usr/bin/python-pip install whisper
	/usr/bin/python-pip install carbon
	/usr/bin/python-pip install graphite-web
	EOH
end