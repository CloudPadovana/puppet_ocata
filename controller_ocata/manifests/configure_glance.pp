class controller_ocata::configure_glance inherits controller_ocata::params {

#
# Questa classe:
# - popola il file /etc/glance/glance-api.conf
# - popola il file /etc/glance/glance-registry.conf
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
                                                                                                                                             
  


# glance-api.conf

#   do_config { 'glance_api_notification_driver': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'notification_driver', value => $controller_ocata::params::glance_notification_driver, }

  do_config { 'glance_enable_v1_api': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'enable_v1_api', value => $controller_ocata::params::glance_enable_v1_api, }

# 25 GB max size for an image
  do_config { 'glance_image_size_cap': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'image_size_cap', value => $controller_ocata::params::glance_image_size_cap, }
  do_config { 'glance_api_registry_host': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'registry_host', value => $controller_ocata::params::vip_mgmt, }
  do_config { 'glance_api_show_multiple_locations': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'show_multiple_locations', value => $controller_ocata::params::glance_api_show_multiple_locations, }
  do_config { 'glance_api_show_image_direct_url': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'show_image_direct_url', value => $controller_ocata::params::glance_api_show_image_direct_url, }
  do_config { 'glance_api_db': conf_file => '/etc/glance/glance-api.conf', section => 'database', param => 'connection', value => $controller_ocata::params::glance_db, }

  do_config { 'glance_api_auth_uri': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }
  do_config { 'glance_api_auth_url': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
  do_config { 'glance_api_project_domain_name': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
  do_config { 'glance_api_user_domain_name': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
  do_config { 'glance_api_project_name': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
  do_config { 'glance_api_username': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::glance_username, }
  do_config { 'glance_api_password': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::glance_password, }
  do_config { 'glance_api_cafile': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
  do_config { 'glance_api_memcached_servers': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }
  do_config { 'glance_api_auth_type': conf_file => '/etc/glance/glance-api.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }

  do_config { 'glance_api_flavor': conf_file => '/etc/glance/glance-api.conf', section => 'paste_deploy', param => 'flavor', value => $controller_ocata::params::flavor, }

  do_config { 'glance_api_store': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'stores', value => $controller_ocata::params::glance_store, }
  do_config { 'glance_api_default_store': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'default_store', value => $controller_ocata::params::glance_api_default_store, }
       
  do_config { 'glance_api_store_datadir': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'filesystem_store_datadir', value => $controller_ocata::params::glance_store_datadir, }
  do_config { 'glance_api_rbd_store_pool': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'rbd_store_pool', value => $controller_ocata::params::glance_api_rbd_store_pool, }
  do_config { 'glance_api_rbd_store_user': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'rbd_store_user', value => $controller_ocata::params::glance_api_rbd_store_user, }
  do_config { 'glance_api_rbd_store_ceph_conf': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'rbd_store_ceph_conf', value => $controller_ocata::params::ceph_rbd_ceph_conf, }
  do_config { 'glance_api_rbd_store_chunk_size': conf_file => '/etc/glance/glance-api.conf', section => 'glance_store', param => 'rbd_store_chunk_size', value => $controller_ocata::params::glance_api_rbd_store_chunk_size, }
###############
# Settings needed for ceilomer       
  do_config { 'glance_api_transport_url': conf_file => '/etc/glance/glance-api.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, }
   
  do_config { 'glance_api_notification_driver': conf_file => '/etc/glance/glance-api.conf', section => 'oslo_messaging_notifications', param => 'driver', value => $controller_ocata::params::glance_notification_driver, }
####Non necessario in ocata
# do_config { 'glance_container_formats': conf_file => '/etc/glance/glance-api.conf', section => 'image_format', param => 'container_formats', value => $controller_ocata::params::glance_container_formats, }
#######Proxy headers parsing
  do_config { 'glance_enable_proxy_headers_parsing': conf_file => '/etc/glance/glance-api.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }

     
  # glance-registry.conf

  do_config { 'glance_reg_db': conf_file => '/etc/glance/glance-registry.conf', section => 'database', param => 'connection', value => $controller_ocata::params::glance_db, }
#  do_config { 'glance_reg_image_verbose': conf_file => '/etc/glance/glance-registry.conf', section => 'DEFAULT', param => 'verbose', value => false, }
  do_config { 'glance_reg_image_size_cap': conf_file => '/etc/glance/glance-registry.conf', section => 'DEFAULT', param => 'image_size_cap', value => $controller_ocata::params::glance_image_size_cap, }
  do_config { 'glance_reg_auth_uri': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }
  do_config { 'glance_reg_auth_url': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
  do_config { 'glance_reg_project_domain_name': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
  do_config { 'glance_reg_user_domain_name': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
  do_config { 'glance_reg_project_name': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
  do_config { 'glance_reg_username': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::glance_username, }
  do_config { 'glance_reg_password': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::glance_password, }
  do_config { 'glance_reg_cafile': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
  do_config { 'glance_reg_memcached_servers': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }
  do_config { 'glance_reg_auth_type': conf_file => '/etc/glance/glance-registry.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }

  do_config { 'glance_reg_flavor': conf_file => '/etc/glance/glance-registry.conf', section => 'paste_deploy', param => 'flavor', value => $controller_ocata::params::flavor, }
 
 # Settings needed for ceilomer       
  do_config { 'glance_reg_notification_driver': conf_file => '/etc/glance/glance-registry.conf', section => 'oslo_messaging_notifications', param => 'driver', value => $controller_ocata::params::glance_notification_driver, }
  do_config { 'glance_reg_transport_url': conf_file => '/etc/glance/glance-registry.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, }
}
