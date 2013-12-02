default["jboss-eap6"]["user"]          		= "jboss"
default["jboss-eap6"]["configuration"]      = "default"
default["jboss-eap6"]["maxperm"]            = "256m"
default["jboss-eap6"]["minheap"]            = "1g"
default["jboss-eap6"]["maxheap"]            = "2g"
default["jboss-eap6"]["preferIPv4Stack"]    = "true"
default["jboss-eap6"]["proxyname"]          = "localhost"
default["jboss-eap6"]["proxyport"]          = "8443"
default["jboss-eap6"]["http_core_threads"]  = "100"
default["jboss-eap6"]["http_queue_length"]  = "100"
default["jboss-eap6"]["http_max_threads"]   = "200"
default["jboss-eap6"]["http_keepalive_time"] = "10"
default["jboss-eap6"]["native_drivers"]			= "true"
default["jboss-eap6"]["addtl_jv_opts"]      = ""
default["jboss-eap6"]["jboss_home"]					= "/usr/share/jbossas"
default["jboss-eap6"]["jboss_deploy"]				= "/usr/local/jboss-deploy"

# admin user/pass (don't use these defaults ;) default password is 'admin123!'
default["jboss-eap6"]["admin_user"]					= "admin"
default["jboss-eap6"]["admin_pass"]					= "d041a4bcc575ab17cf6039a206f72af8"

# which extension modules to load, 
# defaults are based on out of the box standalone.xml
default["jboss-eap6"]["extension_modules"] = [	"org.jboss.as.clustering.infinispan",
																								"org.jboss.as.connector",
																								"org.jboss.as.deployment-scanner",
																								"org.jboss.as.ee",
																								"org.jboss.as.ejb3",
																								"org.jboss.as.jaxrs",
																								"org.jboss.as.jdr",
																								"org.jboss.as.jmx",
																								"org.jboss.as.jpa",
																								"org.jboss.as.jsf",
																								"org.jboss.as.logging",
																								"org.jboss.as.mail",
																								"org.jboss.as.naming",
																								"org.jboss.as.pojo",
																								"org.jboss.as.remoting",
																								"org.jboss.as.sar",
																								"org.jboss.as.security",
																								"org.jboss.as.threads",
																								"org.jboss.as.transactions",
																								"org.jboss.as.web",
																								"org.jboss.as.webservices",
																								"org.jboss.as.weld"
																							]
# Datasource subsystem drivers
# { name => { module => module_name, xa-ds-class => xa-datasource-class, builtin => true/false,
#   destinaiton => download_location, source => download_url }
default["jboss-eap6"]["ds_subsys_drivers"] = { "mysql" => {
																														"module" 			=> "com.mysql",
																														"xa-ds-class" => "com.mysql.jdbc.jdbc2.optional.MysqlXADataSource",
																														"builtin"			=> false,
																														"destination"	=> "com/mysql/main",
																														"source"			=> "http://leleupi.its.yale.edu:8181/PKG/mysql-connector-java-5.1.27.jar",
																														"driverfile"	=> "mysql-connector-java-5.1.27.jar"
																													},
																								"oracle" => {
																														"module"			=> "com.oracle.ojdbc6",
																														"xa-ds-class"	=> "oracle.jdbc.OracleDriver",
																														"builtin"			=> false,
																														"destination"	=> "com/oracle/ojdbc6/main",
																														"source"			=> "http://leleupi.its.yale.edu:8181/PKG/ojdbc6.jar",
																														"driverfile"	=> "ojdbc6.jar"
																													},
																								"h2"			=> {
																														"module"			=> "com.h2database.h2",
																														"xa-ds-class"	=> "org.h2.jdbcx.JdbcDataSource",
																														"builtin"			=> true,
																														"destination" => "",
																														"source"			=> "",
																														"driverfile"	=> ""
																													}
																							}




