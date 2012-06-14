#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?("centos","redhat","fedora")
  include_recipe "yum"
end

package "python" do
  package_name "python"
  action [:install, :upgrade]
end

include_recipe "python::pip"