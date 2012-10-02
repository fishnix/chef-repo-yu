#
# Cookbook Name:: collectd
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

package "collectd" do
  package_name "collectd"
  action [ :install, :upgrade ]
end

service "collectd" do
  supports :status => true, :restart => true, :stop => true, :start => true
end

directory node[:collectd][:data_dir] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# system.properties
template "/etc/collectd.conf" do
    source  "collectd.conf.erb"
    owner   "root"
    group   "root"
    mode    "0444"
    notifies :restart, resources(:service => "collectd"), :delayed
end

node[:collectd][:plugins].each do |p|
  include_recipe "collectd::collectd-#{p}"
end