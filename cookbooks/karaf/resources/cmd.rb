#
# Cookbook Name:: karaf
# Resource:: cmd
#
# Copyright 2011, Opscode, Inc.
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

actions :none, :run, :create_fabric, :enable_mc, :join_fabric
default_action :run

attribute :name, :kind_of => String, :name_attribute => true
attribute :cookbook, :kind_of => String, :default => "karaf"

# SSH connection attributes
attribute :ssh_user, :kind_of => String, :default => 'admin'
attribute :ssh_pass, :kind_of => String, :default => 'admin'
attribute :ssh_port, :kind_of => Integer, :default => 8101
attribute :ssh_host, :kind_of => String, :default => '127.0.0.1'

# Direct command attributes
attribute :command, :kind_of => String, :required => true
attribute :args, :kind_of => String

# Fabric Creation/Joining attributes
attribute :zookeeper_url, :kind_of => String, :default => "192.168.1.5:2181"
attribute :zookeeper_password, :kind_of => String, :default => "admin"
attribute :global_resolver, :kind_of => String, :equal_to => ['localip', 'localhostname', 'publicip', 'publichostname', 'manualip'], :default => 'localhostname'
attribute :local_resolver, :kind_of => String, :equal_to => ['localip', 'localhostname', 'publicip', 'publichostname', 'manualip'], :default => 'localhostname'
attribute :manual_ip, :kind_of => String
attribute :clean, :kind_of => [TrueClass, FalseClass], :default => false
attribute :container_name, :kind_of => String
