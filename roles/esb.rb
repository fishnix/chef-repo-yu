name "esb"
description "Role to create an ESB"
run_list(
  "recipe[java]",
  "recipe[apache-servicemix]",
  "recipe[apache-activemq]",
)