class controller_ocata::configure_heat {

#
# Questa classe:
# - popola il file /etc/heat/heat.conf
# 
  
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
                                                                                                                                             
  
# heat.conf

 do_config { 'heat_verbose': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'verbose', value => $controller_ocata::params::heat_verbose, }
 
do_config { 'heat_transport_url': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, } 
 ###
  do_config { 'heat_metadata_server_url': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'heat_metadata_server_url', value => $controller_ocata::params::heat_metadata_server_url, }
  do_config { 'heat_waitcondition_server_url': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'heat_waitcondition_server_url', value => $controller_ocata::params::heat_waitcondition_server_url, }
  do_config { 'heat_stack_domain_admin': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'stack_domain_admin', value => $controller_ocata::params::heat_stack_domain_admin, }
  do_config { 'heat_stack_domain_admin_password': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'stack_domain_admin_password', value => $controller_ocata::params::heat_stack_domain_admin_password, }
  do_config { 'heat_stack_user_domain_name': conf_file => '/etc/heat/heat.conf', section => 'DEFAULT', param => 'stack_user_domain_name', value => $controller_ocata::params::heat_stack_user_domain_name, }

  do_config { 'heat_db': conf_file => '/etc/heat/heat.conf', section => 'database', param => 'connection', value => $controller_ocata::params::heat_db, }


   do_config { 'heat_auth_uri': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }   
   do_config { 'heat_auth_url': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'heat_keystone_authtoken_memcached_servers': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }
   do_config { 'heat_auth_type': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'heat_project_domain_name': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'heat_user_domain_name': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'heat_project_name': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'heat_username': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::heat_username, }
   do_config { 'heat_password': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::heat_password, }
   do_config { 'heat_cafile': conf_file => '/etc/heat/heat.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
              
   do_config { 'heat_trustee_auth_plugin': conf_file => '/etc/heat/heat.conf', section => 'trustee', param => 'auth_plugin', value => $controller_ocata::params::auth_plugin, }
   do_config { 'heat_trustee_auth_url': conf_file => '/etc/heat/heat.conf', section => 'trustee', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'heat_trustee_username': conf_file => '/etc/heat/heat.conf', section => 'trustee', param => 'username', value => $controller_ocata::params::heat_username, }
   do_config { 'heat_trustee_password': conf_file => '/etc/heat/heat.conf', section => 'trustee', param => 'password', value => $controller_ocata::params::heat_password, }
   do_config { 'heat_trustee_user_domain_name': conf_file => '/etc/heat/heat.conf', section => 'trustee', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }

   do_config { 'heat_ec2authtoken_auth_uri': conf_file => '/etc/heat/heat.conf', section => 'ec2authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }         
   do_config { 'heat_clients_keystone_auth_uri': conf_file => '/etc/heat/heat.conf', section => 'clients_keystone', param => 'auth_uri', value => $controller_ocata::params::heat_clients_keystone_auth_uri, }   
   do_config { 'heat_clients_keystone_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_keystone', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_keystone_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_keystone', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_keystone_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_keystone', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   

   do_config { 'heat_clients_neutron_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_neutron', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_neutron_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_neutron', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_neutron_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_neutron', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   

   do_config { 'heat_clients_nova_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_nova', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_nova_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_nova', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_nova_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_nova', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   

   do_config { 'heat_clients_cinder_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_cinder', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_cinder_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_cinder', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_cinder_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_cinder', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   
    
   do_config { 'heat_clients_ceilometer_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_ceilometer', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_ceilometer_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_ceilometer', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_ceilometer_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_ceilometer', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   

   do_config { 'heat_clients_glance_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_glance', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_glance_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_glance', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_glance_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_glance', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   

   do_config { 'heat_clients_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   

       do_config { 'heat_clients_heat_endpoint_type': conf_file => '/etc/heat/heat.conf', section => 'clients_heat', param => 'endpoint_type', value => $controller_ocata::params::heat_endpoint_type, }   
   do_config { 'heat_clients_heat_ca_file': conf_file => '/etc/heat/heat.conf', section => 'clients_heat', param => 'ca_file', value => $controller_ocata::params::cafile, }   
   do_config { 'heat_clients_heat_insecure': conf_file => '/etc/heat/heat.conf', section => 'clients_heat', param => 'insecure', value => $controller_ocata::params::heat_insecure, }   
#######parametro per risolvere problema connessione endpoint https
   do_config { 'heat_enable_proxy_headers_parsing': conf_file => '/etc/heat/heat.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }
#################       
}
