#
# Cookbook Name:: xinetd
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

if platform?("centos","redhat","fedora")  
  yum_package "xinetd" do
    action [ :install, :upgrade ]
  end
  
  service "xinetd" do
    supports :status => true, :restart => true
    action [ :enable, :start ]
    only_if do
      File.exists?("/etc/init.d/xinetd") and
      File.exists?("/etc/xinetd.conf")
    end
  end
  
  # we __should__ be able to define many of these
  # probably with data_bags.  I wanted quick and dirty
  template "/etc/xinetd.d/#{node[:xinetd][:backend_passthrough][:service_name]}" do
    source "backend_passthrough.erb"
    owner "root"
    group "root"
    mode 0444
    backup 5
    notifies :restart, resources(:service => ["xinetd"]), :delayed
  end
  
end