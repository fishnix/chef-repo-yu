default[:yum][:satellite][:server_url] 		= 'https://vm-satprdapp-01.its.yale.edu/XMLRPC'
default[:yum][:satellite][:reg_key] 		= 'CHANGEME'
default[:yum][:satellite][:user]		= 'CHANGEME'
default[:yum][:satellite][:pass]		= 'CHANGEME'
default[:yum][:satellite][:certurl] 	= "http://vm-satprdapp-01.its.yale.edu/pub/RHN-ORG-TRUSTED-SSL-CERT"

default[:yum][:keepcache]           = "0"
default[:yum][:exactarch]           = "1"
default[:yum][:obsoletes]           = "1"
default[:yum][:gpgcheck]            = "1"
default[:yum][:plugins]             = "1"