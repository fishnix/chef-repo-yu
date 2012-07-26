name "web-vagrant"
description "Role to create a JBoss server on vagrant"
run_list(
  "recipe[yum]",
  "recipe[misc::hosts]",
  "recipe[apache2]"
)
default_attributes(
)