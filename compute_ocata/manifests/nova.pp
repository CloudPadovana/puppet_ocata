class compute_ocata::nova {



include compute_ocata::install


# $novapackages = [ "openstack-nova-compute",
#                     "openstack-nova-common" ]
# package { $novapackages: ensure => "installed" }



     file { '/etc/nova/nova.conf':
               ensure   => present,
               require    => Package["openstack-nova-common"],
          }


#     file { '/etc/nova/policy.json':
#               source      => 'puppet:///modules/compute_ocata/policy.json',
#               path        => '/etc/nova/policy.json',
#               backup      => true,
#          }
 

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
# nova.conf
#

####
  do_config { 'nova_enabled_apis': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'enabled_apis', value => $compute_ocata::params::nova_enabled_apis, }

#####
####rpc_backend e' sostituito da transport url
  do_config { 'nova_transport_url': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'transport_url', value => $compute_ocata::params::transport_url, }

####

####
### do_config { 'nova_auth_strategy': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'auth_strategy', value => $compute_ocata::params::auth_strategy, }

  do_config { 'nova_auth_strategy': conf_file => '/etc/nova/nova.conf', section => 'api', param => 'auth_strategy', value => $compute_ocata::params::auth_strategy, }

####
  do_config { 'nova_use_neutron': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'use_neutron', value => $compute_ocata::params::nova_use_neutron}
  do_config { 'nova_my_ip': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'my_ip', value => $compute_ocata::params::my_ip, }
  do_config { 'nova_firewall_driver': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'firewall_driver', value => $compute_ocata::params::nova_firewall_driver, }

######
###  do_config { 'nova_linuxnet_int_driver': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'linuxnet_interface_driver', value => $compute_ocata::params::linuxnet_int_driver, }
  do_config { 'nova_cpu_allocation_ratio': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'cpu_allocation_ratio', value => $compute_ocata::params::cpu_allocation_ratio, }
do_config { 'nova_ram_allocation_ratio': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'ram_allocation_ratio', value => $compute_ocata::params::ram_allocation_ratio, }  
 do_config { 'nova_allow_resize': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'allow_resize_to_same_host', value => $compute_ocata::params::allow_resize, }



######


  do_config { 'nova_auth_type': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'auth_type', value => $compute_ocata::params::auth_type}
  do_config { 'nova_project_domain_name': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $compute_ocata::params::project_domain_name, }
  do_config { 'nova_user_domain_name': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $compute_ocata::params::user_domain_name, }
  do_config { 'nova_authuri': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $compute_ocata::params::auth_uri, }
  do_config { 'nova_auth_url': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'auth_url', value => $compute_ocata::params::auth_url, }
####qui sembra ok
  do_config { 'nova_keystone_authtoken_memcached_servers': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $compute_ocata::params::memcached_servers, }
########
  do_config { 'nova_project_name': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'project_name', value => $compute_ocata::params::project_name, }
  do_config { 'nova_username': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'username', value => $compute_ocata::params::nova_username, }
  do_config { 'nova_password': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'password', value => $compute_ocata::params::nova_password, }
  do_config { 'nova_cafile': conf_file => '/etc/nova/nova.conf', section => 'keystone_authtoken', param => 'cafile', value => $compute_ocata::params::cafile, }

  do_config { 'nova_vnc_enabled': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'enabled', value => $compute_ocata::params::vnc_enabled, }
  do_config { 'nova_vncserver_listen': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'vncserver_listen', value => $compute_ocata::params::vncserver_listen, }
  do_config { 'nova_vncserver_proxy': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'vncserver_proxyclient_address', value => $compute_ocata::params::my_ip, }
  do_config { 'nova_novncproxy': conf_file => '/etc/nova/nova.conf', section => 'vnc', param => 'novncproxy_base_url', value => $compute_ocata::params::novncproxy_base_url, }

  do_config { 'nova_glance': conf_file => '/etc/nova/nova.conf', section => 'glance', param => 'api_servers', value => $compute_ocata::params::glance_api_servers, }

  do_config { 'nova_lock_path': conf_file => '/etc/nova/nova.conf', section => 'oslo_concurrency', param => 'lock_path', value => $compute_ocata::params::nova_lock_path, }
#############
  do_config { 'nova_placement_os_region_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'os_region_name', value => $compute_ocata::params::region_name, }
  do_config { 'nova_placement_project_domain_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'project_domain_name', value => $compute_ocata::params::project_domain_name, }
  do_config { 'nova_placement_project_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'project_name', value => $compute_ocata::params::project_name, }
do_config { 'nova_placement_auth_type': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'auth_type', value => $compute_ocata::params::auth_type, }
  do_config { 'nova_placement_user_domain_name': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'user_domain_name', value => $compute_ocata::params::user_domain_name, }
  do_config { 'nova_placement_auth_url': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'auth_url', value => $compute_ocata::params::placement_auth_url, }
  do_config { 'nova_placement_username': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'username', value => $compute_ocata::params::placement_username, }
  do_config { 'nova_placement_password': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'password', value => $compute_ocata::params::placement_password, }
  do_config { 'nova_placement_cafile': conf_file => '/etc/nova/nova.conf', section => 'placement', param => 'cafile', value => $compute_ocata::params::cafile, }
#####ok questa sezione

  do_config { 'nova_neutron_auth_url': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'auth_url', value => $compute_ocata::params::auth_url, }
  do_config { 'nova_neutron_auth_type': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'auth_type', value => $compute_ocata::params::auth_type, }
  do_config { 'nova_neutron_project_domain_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'project_domain_name', value => $compute_ocata::params::project_domain_name, }
  do_config { 'nova_neutron_user_domain_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'user_domain_name', value => $compute_ocata::params::user_domain_name, }
  do_config { 'nova_neutron_region_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'region_name', value => $compute_ocata::params::region_name, }
  do_config { 'nova_neutron_project_name': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'project_name', value => $compute_ocata::params::project_name, }
  do_config { 'nova_neutron_username': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'username', value => $compute_ocata::params::neutron_username, }
  do_config { 'nova_neutron_password': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'password', value => $compute_ocata::params::neutron_password, }
  do_config { 'nova_neutron_url': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'url', value => $compute_ocata::params::neutron_url, }
  do_config { 'nova_neutron_cafile': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'cafile', value => $compute_ocata::params::cafile, }

###
#  do_config { 'nova_ssl_ca_file': conf_file => '/etc/nova/nova.conf', section => 'neutron', param => 'ssl_ca_file', value => $compute_ocata::params::cafile, }
  do_config { 'nova_libvirt_inject_pass': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'inject_password', value => $compute_ocata::params::libvirt_inject_pass, }
  do_config { 'nova_libvirt_inject_key': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'inject_key', value => $compute_ocata::params::libvirt_inject_key, }
  do_config { 'nova_libvirt_inject_part': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'inject_partition', value => $compute_ocata::params::libvirt_inject_part, }

#######
if $cloud_role == "is_prod_sharedstorage" or $cloud_role == "is_prod_localstorage" {
###   do_config { 'nova_live': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'live_migration_flag', value => $compute_ocata::params::live_migration_flag, }
  do_config { 'nova_libvirt_cpu_mode': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'cpu_mode', value => $compute_ocata::params::libvirt_cpu_mode, }
  do_config { 'nova_libvirt_cpu_model': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'cpu_model', value => $compute_ocata::params::libvirt_cpu_model, }
}
####config di libvirt per utilizzare ceph
  do_config { 'nova_libvirt_rbd_user': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'rbd_user', value => $compute_ocata::params::libvirt_rbd_user, }
  do_config { 'nova_libvirt_rbd_secret_uuid': conf_file => '/etc/nova/nova.conf', section => 'libvirt', param => 'rbd_secret_uuid', value => $compute_ocata::params::libvirt_rbd_secret_uuid, }
  do_config { 'nova_cinder_ssl_ca_file': conf_file => '/etc/nova/nova.conf', section => 'cinder', param => 'ssl_ca_file', value => $compute_ocata::params::cafile, }
  do_config { 'nova_cinder_cafile': conf_file => '/etc/nova/nova.conf', section => 'cinder', param => 'cafile', value => $compute_ocata::params::cafile, }

######
#
# nova.conf for Ceilometer
#
  do_config { 'nova_instance_usage_audit': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'instance_usage_audit', value => $compute_ocata::params::nova_instance_usage_audit, }
  do_config { 'nova_instance_usage_audit_period': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'instance_usage_audit_period', value => $compute_ocata::params::nova_instance_usage_audit_period, }
  do_config { 'nova_notify_on_state_change': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'notify_on_state_change', value => $compute_ocata::params::nova_notify_on_state_change, }
  do_config { 'nova_notification_driver': conf_file => '/etc/nova/nova.conf', section => 'DEFAULT', param => 'notification_driver', value => $compute_ocata::params::nova_notification_driver, }

}
