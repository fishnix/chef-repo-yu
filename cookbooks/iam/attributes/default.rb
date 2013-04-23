# common stuff
default[:iam][:tmpdir] = "/tmp"

# identityiq stuff
default[:iam][:identityiq][:dbhost] = '127.0.0.1'
default[:iam][:identityiq][:dbname] = 'identityiq'
default[:iam][:identityiq][:dbuser] = 'identityiq'
default[:iam][:identityiq][:dbpass] = 'identityiq'

# radiantone/vds stuff
default[:iam][:radiantone][:user] = "jbossa"
default[:iam][:radiantone][:rpm_file] = 'radiantone-vds-ics-6.0.2-1.x86_64.rpm'
default[:iam][:radiantone][:rpm_source] = 'http://localhost/radiantone-vds-ics-6.0.2-1.x86_64.rpm'
default[:iam][:radiantone][:r_home] = "/usr/local/radiantone"