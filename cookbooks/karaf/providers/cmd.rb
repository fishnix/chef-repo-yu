#
# Cookbook Name:: karaf
# Provider:: cmd
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

require 'net/ssh' 

action :run do
	Net::SSH.start(@new_resource.ssh_host, @new_resource.ssh_user, :password => @new_resource.ssh_pass, :port => @new_resource.ssh_port) do |ssh|
		result = ssh.exec!(@new_resource.command)
		Chef::Log.info "Output: #{result}"
	end
end

action :enable_mc do
	Net::SSH.start(@new_resource.ssh_host, @new_resource.ssh_user, :password => @new_resource.ssh_pass, :port => @new_resource.ssh_port) do |ssh|
		if ssh.exec!('features:list | grep fabric-webui ').include?('[uninstalled]')
			Chef::Log.info "fabric-webui feature not installed, installing."
			ssh.exec!(" profile-edit --features fabric-webui fabric")
		end
	end
end

action :create_fabric do
	Net::SSH.start(@new_resource.ssh_host, @new_resource.ssh_user, :password => @new_resource.ssh_pass, :port => @new_resource.ssh_port) do |ssh|
		if ssh.exec!('fabric:status').include?('Command not found:')
			Chef::Log.info "Fabric not created, creating."
			cmd = 'fabric:create'
			cmd << " -g #{@new_resource.global_resolver}"  unless @new_resource.global_resolver.nil?
			cmd << " -r #{@new_resource.local_resolver}"  unless @new_resource.local_resolver.nil?
			cmd << " -m #{@new_resource.manual_ip}" unless @new_resource.manual_ip.nil?
			cmd << " --clean" if @new_resource.clean
			ssh.exec!(cmd)
		end
	end
end

action :join_fabric do
	Net::SSH.start(@new_resource.ssh_host, @new_resource.ssh_user, :password => @new_resource.ssh_pass, :port => @new_resource.ssh_port) do |ssh|
		if ssh.exec!('fabric:status').include?('Command not found:')
			Chef::Log.info "Fabric not joined, joining."
			cmd = 'fabric:join -f'
			cmd << " -r #{@new_resource.local_resolver}"  unless @new_resource.local_resolver.nil?
			cmd << " -m #{@new_resource.manual_ip}" unless @new_resource.manual_ip.nil?
			cmd << " --zookeeper-password=#{@new_resource.zookeeper_password}"
			cmd << " #{@new_resource.zookeeper_url}"
			cmd << " #{@new_resource.container_name}" unless @new_resource.container_name.nil?
			ssh.exec!(cmd)
		end
	end
end

