class controller_ocata::configure_ceilometer {

#
# Questa classe:
# - popola il file /etc/ceilometer/ceilometer.conf
#
 
##########ceilometer package

 $ceilometerpackages = [ "openstack-ceilometer-collector",
                         "openstack-ceilometer-notification",
                         "openstack-ceilometer-central", 
                         "python-ceilometerclient" ]

 package { $ceilometerpackages: ensure => "installed" }

########

 
define do_config ($conf_file, $section, $param, $value) {
             exec { "${name}":
                              command     => "/usr/bin/openstack-config --set ${conf_file} ${section} ${param} \"${value}\"",
                              require     => Package['openstack-utils'],
                              unless      => "/usr/bin/openstack-config --get ${conf_file} ${section} ${param} 2>/dev/null | /bin/grep -- \"^${value}$\" 2>&1 >/dev/null",
                  }
       }

define remove_config ($conf_file, $section, $param, $value) {
             exec { "${name}":
                              command     => "/usr/bin/openstack-config --del ${conf_file} ${section} ${param}",
                              require     => Package['openstack-utils'],
                              onlyif      => "/usr/bin/openstack-config --get ${conf_file} ${section} ${param} 2>/dev/null | /bin/grep -- \"^${value}$\" 2>&1 >/dev/null",
                   }
       }
                                                                                                                                             
  

                                                                                                                                  
# ceilometer.conf
   do_config { 'ceilometer_connection': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'database', param => 'connection', value => $controller_ocata::params::ceilometer_connection, }
   ####ok
   do_config { 'ceilometer_metering_time_to_live': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'database', param => 'metering_time_to_live', value => $controller_ocata::params::ceilometer_metering_time_to_live, }
       
   do_config { 'ceilometer_verbose': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'verbose', value => $controller_ocata::params::ceilometer_verbose, }
###########
#  
###transport_url
do_config { 'ceilometer_transport_url': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, }
#############
   do_config { 'ceilometer_auth_strategy': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'auth_strategy', value => $controller_ocata::params::auth_strategy, }
# See https://issues.infn.it/jira/browse/PDCL-749
   do_config { 'ceilometer_default_log_levels': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'default_log_levels', value => $controller_ocata::params::ceilometer_default_log_levels, }


   do_config { 'ceilometer_auth_uri': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }
   do_config { 'ceilometer_auth_url': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'ceilometer_memcached_servers': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }
   do_config { 'ceilometer_project_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'ceilometer_username': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::ceilometer_username, }
   do_config { 'ceilometer_password': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::ceilometer_password, }
   do_config { 'ceilometer_cafile': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
   do_config { 'ceilometer_auth_type': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'ceilometer_project_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'ceilometer_user_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }

   do_config { 'ceilometer_service_credentials_auth_type': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'ceilometer_service_credentials_auth_url': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'auth_url', value => $controller_ocata::params::ceilometer_service_credentials_auth_url, }
   do_config { 'ceilometer_service_credentials_project_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'ceilometer_service_credentials_user_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'ceilometer_service_credentials_project_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'ceilometer_service_credentials_username': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'username', value => $controller_ocata::params::ceilometer_username, }
   do_config { 'ceilometer_service_credentials_password': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'password', value => $controller_ocata::params::ceilometer_password, }
   do_config { 'ceilometer_service_credentials_interface': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'interface', value => $controller_ocata::params::ceilometer_service_credentials_interface, }
   do_config { 'ceilometer_service_credentials_region_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'region_name', value => $controller_ocata::params::region_name, }
   do_config { 'ceilometer_service_credentials_cafile': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'cafile', value => $controller_ocata::params::cafile,
 }
  
# Non serve piu`
##       do_config { 'ceilometer_telemetry_secret': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'publisher', param => 'telemetry_secret', value => $controller_ocata::params::ceilometer_telemetry_secret, }

  do_config { 'ceilometer_meter_dispatchers': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'meter_dispatchers', value => $controller_ocata::params::ceilometer_meter_dispatchers, }
   do_config { 'ceilometer_event_dispatchers': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'event_dispatchers', value => $controller_ocata::params::ceilometer_event_dispatchers, }

#######Proxy headers parsing
do_config { 'ceilometer_enable_proxy_headers_parsing': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }

  }
