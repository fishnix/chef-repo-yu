#
# Cookbook Name:: jdk
# Recipe:: openjdk-1.7
#
# Copyright 2013, Yale University
#
# All rights reserved - Do Not Redistribute
#

%w{ java-1.7.0-openjdk java-1.7.0-openjdk-devel }.each do |p|
	package p do
		action [:install,:upgrade]
	end
end

node.set[:jdk][:java_home] = '/usr/lib/jvm/java-1.7.0/'