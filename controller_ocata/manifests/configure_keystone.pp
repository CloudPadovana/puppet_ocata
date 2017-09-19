class controller_ocata::configure_keystone {

#
# Questa classe:
# - popola il file /etc/keystone/keystone.conf
# - crea il file /etc/httpd/conf.d/wsgi-keystone.conf
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
                                                                                                                                             
                                                                                                                                 
# keystone.conf
   do_config { 'keystone_admin_token': conf_file => '/etc/keystone/keystone.conf', section => 'DEFAULT', param => 'admin_token', value => $controller_ocata::params::admin_token, }

#####verificare se effettivamente vanno configurati public_endpoint e admin_endpoint   
  do_config { 'keystone_public_endpoint': conf_file => '/etc/keystone/keystone.conf', section => 'DEFAULT', param => 'public_endpoint', value => $controller_ocata::params::keystone_public_endpoint, }
   do_config { 'keystone_admin_endpoint': conf_file => '/etc/keystone/keystone.conf', section => 'DEFAULT', param => 'admin_endpoint', value => $controller_ocata::params::keystone_admin_endpoint, }
#########  
   do_config { 'keystone_db': conf_file => '/etc/keystone/keystone.conf', section => 'database', param => 'connection', value => $controller_ocata::params::keystone_db, }

  do_config { 'keystone_token_provider': conf_file => '/etc/keystone/keystone.conf', section => 'token', param => 'provider', value => $controller_ocata::params::keystone_token_provider, }
   do_config { 'keystone_token_expiration': conf_file => '/etc/keystone/keystone.conf', section => 'token', param => 'expiration', value => $controller_ocata::params::token_expiration, }

#######Proxy headers parsing
do_config { 'keystone_enable_proxy_headers_parsing': conf_file => '/etc/keystone/keystone.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }


##  do_config { 'keystone_auth_methods': conf_file => '/etc/keystone/keystone.conf', section => 'auth', param => 'methods', value => $controller_ocata::params::keystone_auth_methods, }


# Create file /etc/httpd/conf.d/wsgi-keystone.conf
#  if $cloud_role == "is_production"  { 
#   file {'wsgi-keystone.conf':
#                  source      => 'puppet:///modules/controller_ocata/wsgi-keystone.conf',
#                  path        => '/etc/httpd/conf.d/wsgi-keystone.conf',
#     }
#  }

file {'/etc/httpd/conf.d/wsgi-keystone.conf':
              ensure      => link,
              target      => '/usr/share/keystone/wsgi-keystone.conf',
          }

     
  }
