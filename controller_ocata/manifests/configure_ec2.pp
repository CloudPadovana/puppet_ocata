class controller_ocata::configure_ec2 inherits controller_ocata::params {

#
# Questa classe:
# - popola il file /etc/ec2api/ec2api.conf
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
                                                                                                                                             

# ec2api.conf
   do_config { 'ec2_keystone_url': conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'keystone_url', value => $controller_ocata::params::ec2_keystone_url, }
   do_config { 'ec2_my_ip': conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'my_ip', value => $controller_ocata::params::ec2_my_ip, }
   do_config { 'ec2_external_network': conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'external_network', value => $controller_ocata::params::ec2_external_network, }
   do_config { 'ec2_ssl_ca_file': conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'ssl_ca_file', value => $controller_ocata::params::cafile, }
   do_config { 'ec2_log_file': conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'log_file', value => $controller_ocata::params::ec2_log_file, }
   do_config { 'ec2_full_vpc_support': conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'full_vpc_support', value => $controller_ocata::params::ec2_full_vpc_support, }
   do_config { 'keystone_ec2_tokens_url':  conf_file => '/etc/ec2api/ec2api.conf', section => 'DEFAULT', param => 'keystone_ec2_tokens_url', value => "${controller_ocata::params::ec2_keystone_url}/ec2tokens",}
   do_config { 'ec2_db': conf_file => '/etc/ec2api/ec2api.conf', section => 'database', param => 'connection', value => $controller_ocata::params::ec2_db, }
   do_config { 'ec2_auth_uri': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_url, }   
   do_config { 'ec2_auth_url': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }   
   do_config { 'ec2_user': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::ec2_user, }
   do_config { 'ec2_password': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::ec2_password, }
   do_config { 'ec2_tenant_name': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'ec2_project_domain_name': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'ec2_user_domain_name': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'ec2_auth_type': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'ec2_cafile': conf_file => '/etc/ec2api/ec2api.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
   do_config { 'ec2_nova_metadata_ip': conf_file => '/etc/ec2api/ec2api.conf', section => 'metadata', param => 'nova_metadata_ip', value => $controller_ocata::params::ec2_nova_metadata_ip, }
   do_config { 'ec2_auth_ca_cert': conf_file => '/etc/ec2api/ec2api.conf', section => 'metadata', param => 'auth_ca_cert', value => $controller_ocata::params::cafile, }
}
