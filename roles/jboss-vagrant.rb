name "jboss-vagrant"
description "Role to create a JBoss server on vagrant"
run_list(
  "recipe[java]",
  "recipe[jboss]",
  "recipe[jenkins]"
)
default_attributes(
  "java" => { "jdk_url"   => 'http://leleupi.its.yale.edu:8181/PKG/jdk1.6.0_25.tar.gz',
              "jdk_file"  => 'jdk1.6.0_25.tar.gz',
              "java_home" => '/usr/local/jdk1.6.0_25'
            },
  "jboss" => {  "jboss_url"   => 'http://leleupi.its.yale.edu:8181/PKG/jboss-eap-5.0.1.tar.gz',
                "jboss_file"  => 'jboss-eap-5.0.1.tar.gz',
                "jboss_home"  => '/usr/local/jboss-eap-5.0/jboss-as',
                "jboss_apps"  => '/usr/local/jboss-apps',
                "nodes"       => { "node00" => { "node_enabled"  => true } }
              },
  "jenkins" => { "jenkins_url"  => 'http://leleupi.its.yale.edu:8181/PKG/jenkins.war' }
)