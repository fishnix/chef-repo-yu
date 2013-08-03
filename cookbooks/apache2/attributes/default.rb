#
# Cookbook Name:: apache2
# Attributes:: apache
#
# Some of below is borrowed from the opscode apache2 cookbook
# but in general I didn't like that they switched from the centos/redhat
# way to the ubuntu way of managing apache
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

# Where the various parts of apache are
case platform
  when "redhat","centos","fedora","suse"
    default[:apache2][:dir]        = "/etc/httpd"
    default[:apache2][:log_dir]    = "/var/log/httpd"
    default[:apache2][:user]       = "apache"
    default[:apache2][:binary]     = "/usr/sbin/httpd"
    default[:apache2][:icondir]    = "/var/www/icons/"
    default[:apache2][:cache_dir]  = "/var/cache/httpd"
    default[:apache2][:pidfile]    = "/var/run/httpd/httpd.pid"
  when "debian","ubuntu"
    default[:apache2][:dir]        = "/etc/apache2"
    default[:apache2][:log_dir]    = "/var/log/apache2"
    default[:apache2][:user]       = "www-data"
    default[:apache2][:binary]     = "/usr/sbin/apache2"
    default[:apache2][:icondir]    = "/usr/share/apache2/icons"
    default[:apache2][:cache_dir]  = "/var/cache/apache2"
    default[:apache2][:pidfile]    = "/var/run/apache2.pid"
  when "arch"
    default[:apache2][:dir]        = "/etc/httpd"
    default[:apache2][:log_dir]    = "/var/log/httpd"
    default[:apache2][:user]       = "http"
    default[:apache2][:binary]     = "/usr/sbin/httpd"
    default[:apache2][:icondir]    = "/usr/share/httpd/icons"
    default[:apache2][:cache_dir]  = "/var/cache/httpd"
    default[:apache2][:pidfile]    ="/var/run/httpd/httpd.pid"
  else
    default[:apache2][:dir]        = "/etc/apache2"
    default[:apache2][:log_dir]    = "/var/log/apache2"
    default[:apache2][:user]       = "www-data"
    default[:apache2][:binary]     = "/usr/sbin/apache2"
    default[:apache2][:icondir]    = "/usr/share/apache2/icons"
    default[:apache2][:cache_dir]  = "/var/cache/apache2"
    default[:apache2][:pidfile]    = "logs/httpd.pid"
end

# General settings
default[:apache2][:listen_ports] = [ "80" ]
default[:apache2][:contact] = "root"
default[:apache2][:timeout] = 300
default[:apache2][:keepalive] = "On"
default[:apache2][:keepaliverequests] = 100
default[:apache2][:keepalivetimeout] = 5
default[:apache2][:namevhost] = "On"
default[:apache2][:namevhosts] = [ "127.0.0.1:80", "*:80" ]

# Security
default[:apache2][:servertokens] = "Prod"
default[:apache2][:serversignature] = "On"
default[:apache2][:traceenable] = "Off"
default[:apache2][:serverstatus] = "On"
default[:apache2][:serverinfo] = "Off"

# Prefork Attributes
default[:apache2][:prefork][:startservers] = 5
default[:apache2][:prefork][:minspareservers] = 5
default[:apache2][:prefork][:maxspareservers] = 10
default[:apache2][:prefork][:serverlimit] = 20
default[:apache2][:prefork][:maxclients] = 20
default[:apache2][:prefork][:maxrequestsperchild] = 10000

# Worker Attributes
default[:apache2][:worker][:startservers] = 4
default[:apache2][:worker][:maxclients] = 1024
default[:apache2][:worker][:minsparethreads] = 64
default[:apache2][:worker][:maxsparethreads] = 192
default[:apache2][:worker][:threadsperchild] = 64
default[:apache2][:worker][:maxrequestsperchild] = 0

# SSL Atributes
default[:apache2][:ssl][:listen_ports] = [ "443" ]
default[:apache2][:ssl][:SSLPassPhraseDialog] = 'exec:/root/.https_pass'
default[:apache2][:ssl][:DocumentRoot] = '/var/www/vhost/www.thebudgetbabe.com'
default[:apache2][:ssl][:ServerName] = 'www.thebudgetbabe.com:443'
default[:apache2][:ssl][:ServerAlias] = [ 'thebudgetbabe.com:443' ]


