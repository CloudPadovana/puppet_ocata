class controller_ocata::configure_cinder inherits controller_ocata::params {

#
# Questa classe:
# - popola il file /etc/cinder/cinder.conf
# - popola il file /etc/cinder/policy.json
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
                                                                                                                                             
  
# cinder.conf
       
   do_config { 'cinder_auth_strategy': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'auth_strategy', value => $controller_ocata::params::auth_strategy, }       
   do_config { 'cinder_my_ip': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'my_ip', value => $controller_ocata::params::cinder_my_ip, }       
   do_config { 'cinder_public_endpoint': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'public_endpoint', value => $controller_ocata::params::cinder_public_endpoint, }
   do_config { 'cinder_iscsi_helper': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'iscsi_helper', value => $controller_ocata::params::cinder_iscsi_helper, }
   do_config { 'cinder_glance_api_servers': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'glance_api_servers', value => $controller_ocata::params::glance_api_servers, }
   do_config { 'cinder_enabled_backends': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'enabled_backends', value => $controller_ocata::params::cinder_enabled_backends, }
   do_config { 'cinder_default_volume_type': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'default_volume_type', value => $controller_ocata::params::cinder_default_volume_type, }

  do_config { 'cinder_db': conf_file => '/etc/cinder/cinder.conf', section => 'database', param => 'connection', value => $controller_ocata::params::cinder_db, }
#######transport_url
  do_config { 'cinder_transport_url': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, }

#   do_config { 'cinder_rabbit_hosts': conf_file => '/etc/cinder/cinder.conf', section => 'oslo_messaging_rabbit', param => 'rabbit_hosts', value => $controller_ocata::params::rabbit_hosts, }       
#   do_config { 'cinder_rabbit_ha_queues': conf_file => '/etc/cinder/cinder.conf', section => 'oslo_messaging_rabbit', param => 'rabbit_ha_queues', value => $controller_ocata::params::rabbit_ha_queues, }

   do_config { 'cinder_auth_uri': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }   
   do_config { 'cinder_auth_url': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'cinder_auth_type': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'cinder_project_domain_name': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'cinder_user_domain_name': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'cinder_project_name': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'cinder_username': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::cinder_username, }
   do_config { 'cinder_password': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::cinder_password, }
   do_config { 'cinder_cafile': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
   do_config { 'cinder_keystone_authtoken_memcached_servers': conf_file => '/etc/cinder/cinder.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }

   do_config { 'cinder_lock_path': conf_file => '/etc/cinder/cinder.conf', section => 'oslo_concurrency', param => 'lock_path', value => $controller_ocata::params::cinder_lock_path, }
##########Iscsi
   do_config { 'cinder_iscsi_volume_group': conf_file => '/etc/cinder/cinder.conf', section => 'iscsi-infnpd', param => 'volume_group', value => $controller_ocata::params::iscsi_volume_group, }
   do_config { 'cinder_iscsi_volume_backend_name': conf_file => '/etc/cinder/cinder.conf', section => 'iscsi-infnpd', param => 'volume_backend_name', value => $controller_ocata::params::iscsi_volume_backend_name, }
   do_config { 'cinder_iscsi_volume_driver': conf_file => '/etc/cinder/cinder.conf', section => 'iscsi-infnpd', param => 'volume_driver', value => $controller_ocata::params::iscsi_volume_driver, }
   do_config { 'cinder_iscsi_shares_config': conf_file => '/etc/cinder/cinder.conf', section => 'iscsi-infnpd', param => 'nfs_shares_config', value => $controller_ocata::params::cinder_iscsi_shares_config, }
   do_config { 'cinder_iscsi_nfs_mount_point_base': conf_file => '/etc/cinder/cinder.conf', section => 'iscsi-infnpd', param => 'nfs_mount_point_base', value => $controller_ocata::params::cinder_iscsi_nfs_mount_point_base, }
############# Ceph configuration
 do_config { 'cinder_ceph_volume_group': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'volume_group', value => $controller_ocata::params::ceph_volume_group, }
   do_config { 'cinder_ceph_volume_backend_name': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'volume_backend_name', value => $controller_ocata::params::ceph_volume_backend_name, }
   do_config { 'cinder_ceph_volume_driver': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'volume_driver', value => $controller_ocata::params::ceph_volume_driver, }
   do_config { 'cinder_ceph_rbd_pool': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_pool', value => $controller_ocata::params::cinder_ceph_rbd_pool, }
   do_config { 'cinder_ceph_rbd_ceph_conf': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_ceph_conf', value => $controller_ocata::params::ceph_rbd_ceph_conf, }
   do_config { 'cinder_ceph_rbd_flatten_volume_from_snapshot': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_flatten_volume_from_snapshot', value => $controller_ocata::params::ceph_rbd_flatten_volume_from_snapshot, }
  do_config { 'cinder_ceph_rbd_max_clone_depth': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_max_clone_depth', value => $controller_ocata::params::ceph_rbd_max_clone_depth, }
  do_config { 'cinder_ceph_rbd_store_chunk_size': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_store_chunk_size', value => $controller_ocata::params::ceph_rbd_store_chunk_size, }
  do_config { 'cinder_ceph_rados_connect_timeout': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rados_connect_timeout', value => $controller_ocata::params::ceph_rados_connect_timeout, }
  do_config { 'cinder_ceph_glance_api_version': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'glance_api_version', value => $controller_ocata::params::ceph_glance_api_version, }
  do_config { 'cinder_ceph_rbd_user': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_user', value => $controller_ocata::params::cinder_ceph_rbd_user, }
  do_config { 'cinder_ceph_rbd_secret_uuid': conf_file => '/etc/cinder/cinder.conf', section => 'ceph', param => 'rbd_secret_uuid', value => $controller_ocata::params::cinder_ceph_rbd_secret_uuid, }

#######Proxy headers parsing
do_config { 'cinder_enable_proxy_headers_parsing': conf_file => '/etc/cinder/cinder.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }       
####################       
       
# Settings needed for ceilometer
   do_config { 'cinder_notification_driver': conf_file => '/etc/cinder/cinder.conf', section => 'oslo_messaging_notifications', param => 'driver', value => $controller_ocata::params::cinder_notification_driver, }

#
# Sembra che i seguenti non servano piu`:
##   do_config { 'cinder_control_exchange': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'control_exchange', value => $controller_ocata::params::cinder_control_exchange, }
##   do_config { 'cinder_glusterfs_sparsed_volumes': conf_file => '/etc/cinder/cinder.conf', section => 'DEFAULT', param => 'glusterfs_sparsed_volumes', value => $controller_ocata::params::cinder_glusterfs_sparsed_volumes, }

           
file {'cinder_policy.json':
             source      => 'puppet:///modules/controller_ocata/cinder_policy.json',
             path        => '/etc/cinder/policy.json',
             backup      => true,
             owner   => root,
             group   => cinder,
             mode    => 0640,

           }


       
}
