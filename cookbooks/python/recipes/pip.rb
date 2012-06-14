#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "python-pip" do
  package_name "python-pip"
  action [:install, :upgrade]
end