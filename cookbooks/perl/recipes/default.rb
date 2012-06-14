#
# Cookbook Name:: perl
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "perl" do
  package_name "perl"
  action [:install, :upgrade]
end