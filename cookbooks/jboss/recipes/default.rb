#
# Cookbook Name:: jboss
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
# This is a mockup of a jboss cookbook
# It should work, but I don't plan on using it anywhere
#

include_recipe 'java'

# Install jboss 
# This is total YUCK, but no yum repo for me
# and I didn't want to build CENTOS 6.x pkgs anyways
# aasily swappable with package"jdk" do... stuff
bash "install_jboss" do
  user "root"
  cwd "/usr/local"
  not_if do
    File.exists?("#{node[:jboss][:jboss_home]}")
  end
  code <<-EOH
  /usr/bin/wget "#{node[:jboss][:jboss_url]}"
  /bin/tar -zxf "#{node[:jboss][:jboss_file]}"
  /bin/rm -f "#{node[:jboss][:jboss_file]}"
  EOH
end

# Setup jboss-apps dir
directory "#{node[:jboss][:jboss_apps]}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

# Setup jboss-apps dir
directory "#{node[:jboss][:jboss_logdir]}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

# setup each node in the list
node[:jboss][:nodes].each do |n,c|
 
  # add user if doesn't exist already
  user "#{c['user']}" do
    comment "JBoss User"
    action :create
  end

  # Setup jboss-apps dir
  directory "#{node[:jboss][:jboss_logdir]}/#{n}" do
    owner "#{c['user']}"
    group "#{c['user']}"
    mode 0755
    action :create
  end

  # jboss sysconfig
  template "/etc/sysconfig/jboss_#{n}" do
      source "jboss_sysconfig.erb"
      owner "root"
      group "root"
      mode 0444
      variables(
        :node_name => n,
        :node_conf => c
      )
      #notifies :restart, resources(:service => "jboss_#{n}")
  end

  # jboss init script
  template "/etc/init.d/jboss_#{n}" do
      source "jboss_init.erb"
      owner "root"
      group "root"
      mode 0555
      #notifies :restart, resources(:service => "jboss_#{n}")
  end

  # Create the nodes if they don't exist and the jboss_home dir does
  bash "create_node_#{n}" do
    user "root"
    cwd "#{node[:jboss][:jboss_apps]}"
    not_if { File.exists?("#{node[:jboss][:jboss_apps]}/#{n}") }
    only_if { File.exists?("#{node[:jboss][:jboss_home]}") }
    code <<-EOH
    cp -r #{node[:jboss][:jboss_home]}/server/#{c['type']} #{node[:jboss][:jboss_apps]}/#{n}
    EOH
  end
  
  # create jboss'y subdirs
  %w{ data log tmp webapps work }.each do |d|
    directory "#{node[:jboss][:jboss_apps]}/#{n}/#{d}" do
      owner "#{c['user']}"
      group "#{c['user']}"
      only_if { File.exists?("#{node[:jboss][:jboss_apps]}/#{n}") }
      mode 0755
      action :create
    end
  end
  
  template "#{node[:jboss][:jboss_apps]}/#{n}/conf/props/jms-console-users.properties" do
      source "jms-console-users.properties.erb"
      owner "root"
      group "root"
      mode 0444
  end
    
  service "jboss_#{n}" do
    service_name "jboss_#{n}"
    action :enable
    supports :start => true, :stop => true, :restart => true
  end
end
