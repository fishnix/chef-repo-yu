#
# Cookbook Name:: yum
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
  major_vers = node[:platform_version].to_i

  %w{ CentOS-Base epel }.each do |repo|
    
    template "/etc/yum.repos.d/#{repo}.repo" do
      source "#{repo}.repo.erb"
      owner "root"
      group "root"
      mode 0444
      backup 2
      variables( 
        :major_vers => major_vers 
      )
    end
    
    file "/etc/yum.repos.d/#{repo}.repo-1" do
      action :delete
    end
    
  end
  
  %w{ EPEL }.each do |gpg|
    template "/etc/pki/rpm-gpg/RPM-GPG-KEY-#{gpg}" do
      source "RPM-GPG-KEY-#{gpg}.erb"
      owner "root"
      group "root"
      mode 0444
      variables( 
        :major_vers => major_vers 
      )
    end
  end
  
  %w{ elff dag rpmforge }.each do |repo|
    file "/etc/yum.repos.d/#{repo}.repo" do
      action :delete
    end
  end
  
  yum_package "yum-priorities" do
    action [ :install, :upgrade ]
  end
    
end
