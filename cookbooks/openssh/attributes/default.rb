default[:openssh][:sshd][:port] = "22"
default[:openssh][:sshd][:allow_x_forward] = false
default[:openssh][:sshd][:password_authentication] = false
default[:openssh][:sshd][:permit_root_login] = false
default[:openssh][:sshd][:authorized_keys_file] = '.ssh/authorized_keys'
default[:openssh][:sshd][:allowusers] = [ "" ]