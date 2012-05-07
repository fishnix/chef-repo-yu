current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "fishnix-yale"
client_key               "#{ENV['HOME']}/.chef/fishnix-yale.pem"
validation_client_name   "fishnix-yale-validator"
validation_key           "#{ENV['HOME']}/.chef/fishnix-yale-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/fishnix-yale"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
# Rackspace:
knife[:rackspace_api_key]  = "#{ENV['RACKSPACE_API_KEY']}"
knife[:rackspace_api_username] = "#{ENV['RACKSPACE_API_USER']}"
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