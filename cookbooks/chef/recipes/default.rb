#
# Cookbook Name:: chef
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

directory "/etc/chef" do
  mode "0755"
  owner "root"
  group "root"
  action :create
end

directory "/var/log/chef" do
  mode "0755"
  owner "root"
  group "root"
  action :create
end

file "/etc/chef/validation.pem" do
  mode "0600"
  owner "root"
  group "root"
end

template "/etc/init.d/chef-client" do
  source "chef-client_init.erb"
  owner "root"
  group "root"
  mode "0755"
  backup 5
end

if node[:chef][:run_mode] == "daemon"
  service "chef-client" do
    supports :status => true, :restart => true
    action [ :enable, :start ]
    only_if do
      File.exists?("/etc/init.d/chef-client")
    end
  end

  cron "chef-client" do
    action :delete
  end
else
  service "chef-client" do
    supports :status => true, :restart => true
    action [ :disable, :stop ]
    only_if do
      File.exists?("/etc/init.d/chef-client")
    end
  end

  cron "chef-client" do
    minute "*/30"
    command '/usr/bin/chef-client -L /var/log/chef/client.log -s 20 > /dev/null'
  end
end
