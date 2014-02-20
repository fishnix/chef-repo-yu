#
# Cookbook Name:: openssh
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
  %w{ openssh openssh-server openssh-clients }.each do |pkg|
    yum_package pkg do
      action [ :install, :upgrade ]
    end
  end

end
  
  
service "sshd" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
  only_if do
    File.exists?("/etc/init.d/sshd") and 
    File.exists?("/etc/ssh/sshd_config")
  end
end

#ssh_host_dsa_key
#ssh_host_dsa_key.pub
#ssh_host_key
#ssh_host_key.pub
#ssh_host_rsa_key
#ssh_host_rsa_key.pub

template "/etc/ssh/ssh_config" do
  source "ssh_config.erb"
  owner "root"
  group "root"
  mode 0444
  backup 5
end

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  owner "root"
  group "root"
  mode 0400
  backup 5
  notifies :restart, resources(:service => ["sshd"]), :delayed
end

