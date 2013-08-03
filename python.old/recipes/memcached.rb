# Cookbook Name:: python
# Recipe:: mod_python
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


%w{ python-memcached }.each do |p|
	package p do
	  action [:install, :upgrade]
	end
end
