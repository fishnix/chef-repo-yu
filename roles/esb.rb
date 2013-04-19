name "esb"
description "Role to create an ESB"
run_list(
  "recipe[jdk]",
  "recipe[apache-servicemix]",
  "recipe[apache-activemq]",
)