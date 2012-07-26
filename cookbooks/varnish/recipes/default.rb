#
# Cookbook Name:: varnish
# Recipe:: default
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

if platform?("centos","redhat","fedora")
  include_recipe "yum"
  
  if node[:varnish][:major_vers] == 3 then
    include_recipe "yum::varnish"
  end
  
  %w{ varnish }.each do |pkg|
    yum_package "#{pkg}" do
      action [ :install, :upgrade ]
    end
  end
  
  service "varnish" do
    supports :status => true, :restart => true
    action [ :enable, :start ]
    only_if do
      File.exists?("/etc/init.d/varnish") and 
      File.exists?("/etc/varnish/default.vcl") and
      File.exists?("/etc/sysconfig/varnish") and
      File.exists?("/etc/varnish/secret")
    end
  end
    
  directory "/etc/varnish" do
    mode 0755
    owner "root"
    group "root"
    action :create
  end
  
  template "/etc/varnish/secret" do
    source "secret.erb"
    owner "root"
    group "root"
    mode 0400
    backup 5
  end
  
  template "/etc/varnish/default.vcl" do
    source "default.vcl.erb"
    owner "root"
    group "root"
    mode 0444
    backup 5
    notifies :restart, resources(:service => ["varnish"]), :delayed
  end
  
  template "/etc/sysconfig/varnish" do
    source "sysconfig_varnish.erb"
    owner "root"
    group "root"
    mode 0444
    backup 5
    notifies :restart, resources(:service => ["varnish"]), :delayed
  end
  
end