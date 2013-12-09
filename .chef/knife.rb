current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "#{ENV['CHEF_CLIENT_NAME']}"
client_key               "#{ENV['CHEF_CLIENT_KEY']}"
validation_client_name   "#{ENV['CHEF_VALIDATION_CLIENT']}"
validation_key           "#{ENV['CHEF_VALIDATION_KEY']}"
chef_server_url          "#{ENV['CHEF_SERVER_URL']}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_copyright        "E Camden Fisher"
cookbook_email            "fish@fishnix.net"
cookbook_license          "apachev2"
# Rackspace:
knife[:rackspace_api_key]  = "#{ENV['RACKSPACE_API_KEY']}"
knife[:rackspace_api_username] = "#{ENV['RACKSPACE_API_USER']}"
knife[:rackspace_version] = 'v2'
## EC2:
knife[:aws_ssh_key_id] 		= "#{ENV['AWS_SSH_KEY_ID']}"
knife[:aws_access_key_id]     	= "#{ENV['AWS_ACCESS_KEY_ID']}"
knife[:aws_secret_access_key] 	= "#{ENV['AWS_SECRET_ACCESS_KEY']}"
## Slicehost
#knife[:slicehost_password] = "Your Slicehost API password"
# 
## Terremark
#knife[:terremark_password] = "Your Terremark Password"
#knife[:terremark_username] = "Your Terremark Username"
#knife[:terremark_service]  = "Your Terremark Service name"
# Cloudstack
knife[:cloudstack_access_key_id]     = "#{ENV['CLOUDSTACK_ACCESS_KEY']}"
knife[:cloudstack_secret_access_key] = "#{ENV['CLOUDSTACK_SECRET_KEY']}"
knife[:cloudstack_api_endpoint]      = "#{ENV['CLOUDSTACK_URL']}"
## vSphere
knife[:vsphere_host] = "#{ENV['VSPHERE_HOST']}"
knife[:vsphere_user] = "#{ENV['VSPHERE_USER']}"
knife[:vsphere_pass] = "#{ENV['VSPHERE_PASS']}"
knife[:vsphere_dc] = "#{ENV['VSPHERE_DC']}"
knife[:vsphere_insecure] = true
