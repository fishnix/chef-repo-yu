#
# Cookbook Name:: misc
# Recipe:: hosts
#
# Sometimes /etc/hosts needs some help...
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/hosts" do
    source "hosts.erb"
    owner "root"
    group "root"
    mode 0444
end