#
# Cookbook Name:: apache2
# Recipe:: ssl
#
# Some of below is borrowed from the opscode apache2 cookbook
# but in general I didn't like that they switched from the centos/redhat
# way to the ubuntu way of managing apache
#
# Copyright 2011, E Camden Fisher
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "mod_ssl" do
  case node[:platform]
    when "centos","redhat","fedora","suse"
      package_name "mod_ssl"
    when "debian","ubuntu"
      package_name "mod_ssl"
    when "arch"
      package_name "mod_ssl"
    end
  action :install
end

template "ssl.conf" do
  path "#{node[:apache2][:dir]}/conf.d/ssl.conf"
  source "ssl.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2")
end