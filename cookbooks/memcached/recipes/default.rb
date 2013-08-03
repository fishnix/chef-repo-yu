#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2012, E Camden Fisher
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

package "memcached" do
  package_name "memcached"
  action [ :install, :upgrade ]
end

service "memcached" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template "/etc/sysconfig/memcached" do
  source "memcached.erb"
  owner "root"
  group "root"
  mode 0644
  backup 5
  notifies :restart, resources(:service => "memcached"), :delayed
end