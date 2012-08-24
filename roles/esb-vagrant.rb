name "esb-vagrant"
description "Role to create a Fuse MQ server on vagrant"
run_list(
  "recipe[misc::hosts]",
  "recipe[java]",
  "recipe[fuse-esb]",
  "recipe[jenkins]"
)
default_attributes(
  "java" => { "jdk_url"   => 'http://leleupi.its.yale.edu:8181/PKG/jdk1.6.0_33.tar.gz',
              "jdk_file"  => 'jdk1.6.0_33.tar.gz',
              "java_home" => '/usr/local/jdk1.6.0_33'
            },
  "fuse_esb" => {   "url"   => 'http://leleupi.its.yale.edu:8181/PKG/fuse-esb-full-7.0.0.fuse-061.tar.gz',
                    "file"  => 'fuse-esb-full-7.0.0.fuse-061.tar.gz',
                    "home"  => '/usr/local/fuse-esb'
              }
)