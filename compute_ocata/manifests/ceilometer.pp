class compute_ocata::ceilometer inherits compute_ocata::params {

#include compute_ocata::params
include compute_ocata::install

#  $ceilometerpackages = [ "openstack-ceilometer-compute",
#                          "python-wsme" ]
#                           # ,
#                           #"python-ceilometerclient",
#                           #"python2-pecan" ]
#  package { $ceilometerpackages: ensure => "installed" }



  ###per ocata si modificano le proprieta' del file ceilometer.conf
     file { '/etc/ceilometer/ceilometer.conf':
               ensure   => present,
               mode     => '640',
               group    => 'ceilometer'; 
          }


          
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
                
#
# ceilometer.conf
#
  do_config { 'transport_url': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'transport_url', value => $compute_ocata::params::transport_url, }
  do_config { 'ceilometer_auth_strategy': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'DEFAULT', param => 'auth_strategy', value => $compute_ocata::params::auth_strategy, }
  do_config { 'ceilometer_auth_uri': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $compute_ocata::params::auth_uri, }
  do_config { 'ceilometer_auth_url': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'auth_url', value => $compute_ocata::params::auth_url, }
  do_config { 'ceilometer_project_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'project_name', value => $compute_ocata::params::project_name, }               
  do_config { 'ceilometer_username': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'username', value => $compute_ocata::params::ceilometer_username, }
  do_config { 'ceilometer_password': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'password', value => $compute_ocata::params::ceilometer_password, }
  do_config { 'ceilometer_memcached_servers': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $compute_ocata::params::memcached_servers, }
  do_config { 'ceilometer_auth_type': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'auth_type', value => $compute_ocata::params::auth_type, }
  do_config { 'ceilometer_project_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $compute_ocata::params::project_domain_name, }
  do_config { 'ceilometer_user_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $compute_ocata::params::user_domain_name, }
  #do_config { 'ceilometer_keystone_authtoken_cafile': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'keystone_authtoken', param => 'cafile', value => $compute_ocata::params::cafile, }

  do_config { 'ceilometer_service_credentials_auth_url': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'auth_url', value => $compute_ocata::params::ceilometer_auth_url, }
  do_config { 'ceilometer_service_credentials_username': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'username', value => $compute_ocata::params::ceilometer_username, }
  do_config { 'ceilometer_service_credentials_password': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'password', value => $compute_ocata::params::ceilometer_password, }
  do_config { 'ceilometer_service_credentials_project_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'project_name', value => $compute_ocata::params::project_name, }
  do_config { 'ceilometer_service_credentials_region_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'region_name', value => $compute_ocata::params::region_name, }
  do_config { 'ceilometer_service_credentials_interface': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'interface', value => $compute_ocata::params::ceilometer_interface, }
  do_config { 'ceilometer_service_credentials_auth_type': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'auth_type', value => $compute_ocata::params::auth_type, }

####sulla doc ocata queste variabili sono project_domain_id e user_domain_id
  do_config { 'ceilometer_service_credentials_project_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'project_domain_name', value => $compute_ocata::params::project_domain_name, }
  do_config { 'ceilometer_service_credentials_user_domain_name': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'user_domain_name', value => $compute_ocata::params::user_domain_name, }
do_config { 'ceilometer_service_credentials_cafile': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'service_credentials', param => 'cafile', value => $compute_ocata::params::cafile, }

#############
###check se in nova conf in default ci sono usage audit period notify ib state change e notification driver ...vedi anche in configure.pp
###########check  fatto e ci sono in configure.pp
  
#######Proxy headers parsing
do_config { 'ceilometer_enable_proxy_headers_parsing': conf_file => '/etc/ceilometer/ceilometer.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $compute_ocata::params::enable_proxy_headers_parsing, }


### workload_partitioning
  do_config { 'ceilometer_compute_workload_partitioning':
    conf_file => '/etc/ceilometer/ceilometer.conf',
    section => 'compute',
    param => 'workload_partitioning',
    value => $compute_ocata::params::ceilometer_compute_workload_partitioning,
  }


### instance_discovery_method
  do_config { 'ceilometer_compute_instance_discovery_method':
    conf_file => '/etc/ceilometer/ceilometer.conf',
    section => 'compute',
    param => 'instance_discovery_method',
    value => $compute_ocata::params::ceilometer_compute_instance_discovery_method,
  }

                      
}
