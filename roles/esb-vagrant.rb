name "esb-vagrant"
description "Role to create a Fuse MQ server on vagrant"
run_list(
  "recipe[misc::hosts]",
  "recipe[jdk]",
  "recipe[fuseesb]",
  "recipe[jenkins]"
)
default_attributes(
)