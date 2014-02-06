#
# Cookbook Name:: yum
# Recipe:: satellite
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

# update the cert...
remote_file "/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT" do
  source node[:yum][:satellite][:certurl]
  mode "0644"
  action :create
end

# setup the yum.conf
template "/etc/yum.conf" do
  source "yum.conf.erb"
  owner "root"
  group "root"
  mode 0444
end

# setup the rhnplugin
template "/etc/yum/pluginconf.d/rhnplugin.conf" do
  source "rhnplugin.conf.erb"
  owner "root"
  group "root"
  mode 0444
end