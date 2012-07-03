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

directory "#{node[:jboss][:tmpdir]}" do 
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node[:jboss][:tmpdir]}/#{node[:jboss][:jboss_file]}" do
  source "#{node[:jboss][:jboss_url]}"
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :run, "bash[install_jboss]", :immediately
end

# Install jboss
bash "install_jboss" do
  user "root"
  cwd "/usr/local"
  code <<-EOH
  /bin/tar -zxf "#{node[:jboss][:tmpdir]}/#{node[:jboss][:jboss_file]}"
  EOH
  action :nothing
end

# create "global" jboss dirs
jboss_dirs = [  node[:jboss][:jboss_apps],
                node[:jboss][:jboss_deploy],
                node[:jboss][:jboss_logdir]
              ]
              
jboss_dirs.each do |d|
  directory "#{d}" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end
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
      mode "0555"
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
      mode "0755"
      action :create
    end
  end
  
  template "#{node[:jboss][:jboss_apps]}/#{n}/#{node[:jboss][:jboss_web_deploy]}/server.xml" do
    source "jbossweb_server_xml.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      :ssltype => "#{node[:jboss][:ssltype]}"
    )
  end
  
  if node[:jboss][:ssltype] == "native"
    # copy/generate some crts + keys
  else
    # pull in a vagrant keystore
    remote_file "#{node[:jboss][:jboss_apps]}/#{n}/conf/server.keystore" do
      source "#{node[:jboss][:keystore_url]}"
      action :create_if_missing
      owner "root"
      group "root"
      mode "0644"
    end
  end
  
  template "#{node[:jboss][:jboss_apps]}/#{n}/conf/props/jmx-console-users.properties" do
    source "jmx-console-users.properties.erb"
    owner "root"
    group "root"
    mode "0644"
  end
    
  service "jboss_#{n}" do
    service_name "jboss_#{n}"
    action :enable
    supports :start => true, :stop => true, :restart => true
  end
end
