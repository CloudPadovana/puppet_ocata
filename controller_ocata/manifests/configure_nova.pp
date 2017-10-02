class controller_ocata::configure_nova inherits controller_ocata::params {

#
# Questa classe:
# - popola il file /etc/nova/nova.conf
# - modifica il file /etc/nova/policy.json in modo che solo l'owner di una VM possa farne lo stop e delete
# 
################
### yum -y install openstack-nova-placement-api
# $novapackages = [ "openstack-nova-palacement-api", ]
#  package { $novapackages: ensure => "installed" }

###################  
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
                                                                                                                                             

# nova.conf
###rpc_backend rabbit_hosts e rabbit_ha_queue non ci sono piu' in ocata, 
#   do_config { 'nova_rpc_backend': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'rpc_backend', value => $controller_ocata::params::rpc_backend, }
#####
   do_config { 'nova_transport_url': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, }
######## 
####forse questo va in sezione api e non default 
   do_config { 'nova_auth_strategy': conf_file => '/etc/nova/nova.conf', section => 'api', param => 'auth_strategy', value => $controller_ocata::params::auth_strategy, }
####   
   do_config { 'nova_my_ip': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'my_ip', value => $controller_ocata::params::vip_mgmt, }
   do_config { 'nova_firewall_driver': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'firewall_driver', value => $controller_ocata::params::nova_firewall_driver, }
   do_config { 'nova_use_neutron': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'use_neutron', value => $controller_ocata::params::use_neutron, }
## REMOVED CONF   do_config { 'nova_cpu_allocation_ratio': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'cpu_allocation_ratio', value => $controller_ocata::params::nova_cpu_allocation_ratio, }
#####ok verificati
   do_config { 'nova_enabled_filters': conf_file => '/etc/nova/nova.conf', section => 'filter_scheduler', param => 'enabled_filters', value => $controller_ocata::params::enabled_filters, }
   do_config { 'nova_default_schedule_zone': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'default_schedule_zone', value => $controller_ocata::params::nova_default_schedule_zone, }
   do_config { 'nova_scheduler_max_attempts': conf_file => '/etc/nova/nova.conf', section => 'scheduler', param => 'max_attempts', value => $controller_ocata::params::nova_scheduler_max_attempts, }
   do_config { 'nova_host_subset_size': conf_file => '/etc/nova/nova.conf', section => 'filter_scheduler', param => 'host_subset_size', value => $controller_ocata::params::nova_host_subset_size, }
   do_config { 'nova_host_discover_hosts': conf_file => '/etc/nova/nova.conf', section => 'scheduler', param => 'discover_hosts_in_cells_interval', value => $controller_ocata::params::nova_discover_hosts_in_cells_interval, }
#######    
   do_config { 'nova_vncserver_listen': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'vncserver_listen', value => $controller_ocata::params::vip_pub, }
   do_config { 'nova_vncserver_proxyclient_address': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'vncserver_proxyclient_address', value => $controller_ocata::params::vip_mgmt, }
#####vnc enable
   do_config { 'nova_vnc_enabled': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'enabled', value => $controller_ocata::params::vnc_enabled, }
####
   do_config { 'nova_api_db': conf_file => '/etc/nova/nova.conf', section => 'api_database', param => 'connection', value => $controller_ocata::params::nova_api_db, }

   do_config { 'nova_db': conf_file => '/etc/nova/nova.conf', section => 'database', param => 'connection', value => $controller_ocata::params::nova_db, }
   do_config { 'nova_enabled_apis': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'enabled_apis', value => $controller_ocata::params::enabled_apis, }

   do_config { 'nova_oslo_lock_path': conf_file => '/etc/nova/nova.conf', section => 'oslo_concurrency', param => 'lock_path', value => $controller_ocata::params::nova_oslo_lock_path, }


   do_config { 'nova_memcached_servers': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }
   do_config { 'nova_auth_uri': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }   
   do_config { 'nova_auth_url': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'nova_auth_plugin': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'nova_project_domain_name': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'nova_user_domain_name': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'nova_project_name': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'nova_username': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::nova_username, }
   do_config { 'nova_password': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::nova_password, }
   do_config { 'nova_cafile': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }

   do_config { 'nova_inject_password': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'inject_password', value => $controller_ocata::params::nova_inject_password, }
   do_config { 'nova_inject_key': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'inject_key', value => $controller_ocata::params::nova_inject_key, }
   do_config { 'nova_inject_partition': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'inject_partition', value => $controller_ocata::params::nova_inject_partition, }

   do_config { 'nova_glance_api_servers': conf_file => '/etc/nova/nova.conf', section => 'glance', param => 'api_servers', value => $controller_ocata::params::glance_api_servers, }

####neutron config in nova.conf
   do_config { 'nova_neutron_url': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'url', value => $controller_ocata::params::neutron_url, }
   do_config { 'nova_neutron_auth_type': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'nova_neutron_auth_url': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'nova_neutron_project_domain_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'nova_neutron_user_domain_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'nova_neutron_region_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'region_name', value => $controller_ocata::params::region_name, }
   do_config { 'nova_neutron_project_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'nova_neutron_username': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'username', value => $controller_ocata::params::neutron_username, }
   do_config { 'nova_neutron_password': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'password', value => $controller_ocata::params::neutron_password, }
   do_config { 'nova_neutron_cafile': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'cafile', value => $controller_ocata::params::cafile, }
   do_config { 'nova_service_metadata_proxy': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'service_metadata_proxy', value => $controller_ocata::params::service_metadata_proxy, }
   do_config { 'nova_metadata_proxy_shared_secret': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'metadata_proxy_shared_secret', value => $controller_ocata::params::metadata_proxy_shared_secret, }

#########Placement
   do_config { 'nova_placement_auth_type': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'nova_placement_auth_url': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'auth_url', value => $controller_ocata::params::placement_auth_url, }
   do_config { 'nova_placement_project_domain_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'nova_placement_user_domain_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'nova_placement_region_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'os_region_name', value => $controller_ocata::params::region_name, }
   do_config { 'nova_placement_project_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'nova_placement_username': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'username', value => $controller_ocata::params::placement_username, }
   do_config { 'nova_placement_password': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'password', value => $controller_ocata::params::placement_password, }
   do_config { 'nova_placement_cafile': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'cafile', value => $controller_ocata::params::cafile, }


#################
  do_config { 'nova_cinder_catalog_info': conf_file => '/etc/nova/nova.conf', section => 'cinder', param => 'catalog_info', value => $controller_ocata::params::nova_cinder_catalog_info, }
  do_config { 'nova_cinder_endpoint_template': conf_file => '/etc/nova/nova.conf', section => 'cinder', param => 'endpoint_template', value => $controller_ocata::params::nova_cinder_endpoint_template, }
  do_config { 'nova_cinder_os_region_name': conf_file => '/etc/nova/nova.conf', section => 'cinder', param => 'os_region_name', value => $controller_ocata::params::region_name, }
#######Proxy headers parsing
  do_config { 'nova_enable_proxy_headers_parsing': conf_file => '/etc/nova/nova.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }


# Pare che questi non servano piu`
#   do_config { 'nova_novncproxy_base_url': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'novncproxy_base_url', value => $controller_ocata::params::novncproxy_base_url, }
#   do_config { 'nova_region_name': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'os_region_name', value => $controller_ocata::params::region_name, }

######nova_policy and 00-nova-placement are copied from /controller_ocata/files dir       
file {'nova_policy.json':
           source      => 'puppet:///modules/controller_ocata/nova_policy.json',
           path        => '/etc/nova/policy.json',
           backup      => true,
           owner   => root,
           group   => nova,
           mode    => 0640,

         }
      
file {'00-nova-placement-api.conf':
           source      => 'puppet:///modules/controller_ocata/00-nova-placement-api.conf',
           path        => '/etc/httpd/conf.d/00-nova-placement-api.conf',
           ensure      => present,
           backup      => true,
           mode        => 0640,
         }

 
}
