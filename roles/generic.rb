name "generic"
description "Generic linux role"
env_run_lists(
  "_default" => [ 
      "recipe[users::sysadmins]",
      "recipe[yum::satellite]",
      "recipe[chef]",
      "recipe[misc::packages]",
      "recipe[openssh]"
    ],
  "dev" => [
      "recipe[users::sysadmins]",
      "recipe[yum::satellite]",
      "recipe[chef]",
      "recipe[misc::packages]",
      "recipe[openssh]"
    ],
  "test" => [
      "recipe[users::sysadmins]",
      "recipe[yum::satellite]",
      "recipe[chef]",
      "recipe[misc::packages]",
      "recipe[openssh]"
    ],
  "prod" => [      
      "recipe[users::sysadmins]",
      "recipe[yum::satellite]",
      "recipe[chef]",
      "recipe[misc::packages]",
      "recipe[openssh]"
    ]
)