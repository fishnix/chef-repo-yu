#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright 2013, Yale University
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'jdk'

# add user if doesn't exist already
user node[:logstash][:user] do
  comment "App User"
end