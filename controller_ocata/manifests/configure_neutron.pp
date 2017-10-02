class controller_ocata::configure_neutron inherits controller_ocata::params {

#
# Questa classe:
# - popola il file /etc/neutron/neutron.conf
# - popola il file /etc/neutron/plugins/ml2/ml2_conf.ini
# - popola il file  /etc/neutron/plugins/ml2/openvswitch_agent.ini
# - popola il file /etc/neutron/l3_agent.ini
# - popola il file /etc/neutron/dhcp_agent.ini
# - popola il file /etc/neutron/metadata_agent.ini
# - Definisce il link /etc/neutron/plugin.ini --> /etc/neutron/plugins/ml2/ml2_conf.ini
# - Modifica il file /etc/sudoers.d/neutron in modo che non venga loggato in /var/log/secure un msg ogni 2 sec
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
                                                                                                                                             
  
# neutron.conf
### transport url
   do_config { 'neutron_transport_url': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'transport_url', value => $controller_ocata::params::transport_url, }
   do_config { 'neutron_auth_strategy': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'auth_strategy', value => $controller_ocata::params::auth_strategy, }
   do_config { 'neutron_core_plugin': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'core_plugin', value => $controller_ocata::params::neutron_core_plugin, }
   do_config { 'neutron_service_plugins': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'service_plugins', value => $controller_ocata::params::neutron_service_plugins, }
   do_config { 'neutron_allow_overlapping_ips': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'allow_overlapping_ips', value => $controller_ocata::params::neutron_allow_overlapping_ips, }
   do_config { 'neutron_notify_nova_on_port_status_changes': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'notify_nova_on_port_status_changes', value => $controller_ocata::params::neutron_notify_nova_on_port_status_changes, }
   do_config { 'neutron_notify_nova_on_port_data_changes': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'notify_nova_on_port_data_changes', value => $controller_ocata::params::neutron_notify_nova_on_port_data_changes, }
   do_config { 'neutron_dhcp_agents_per_network': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'dhcp_agents_per_network', value => $controller_ocata::params::dhcp_agents_per_network, }
   do_config { 'neutron_l3_ha': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'l3_ha', value => $controller_ocata::params::neutron_l3_ha, }
   do_config { 'neutron_allow_automatic_l3agent_failover': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'allow_automatic_l3agent_failover', value => $controller_ocata::params::neutron_allow_automatic_l3agent_failover, }
   do_config { 'neutron_max_l3_agents_per_router': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'max_l3_agents_per_router', value => $controller_ocata::params::neutron_max_l3_agents_per_router, }
   do_config { 'neutron_min_l3_agents_per_router': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'min_l3_agents_per_router', value => $controller_ocata::params::neutron_min_l3_agents_per_router, }
   do_config { 'neutron_allow_automatic_dhcp_failover': conf_file => '/etc/neutron/neutron.conf', section => 'DEFAULT', param => 'allow_automatic_dhcp_failover', value => $controller_ocata::params::allow_automatic_dhcp_failover, }

   do_config { 'neutron_db': conf_file => '/etc/neutron/neutron.conf', section => 'database', param => 'connection', value => $controller_ocata::params::neutron_db, }

 #  do_config { 'neutron_rabbit_host': conf_file => '/etc/neutron/neutron.conf', section => 'oslo_messaging_rabbit', param => 'rabbit_hosts', value => $controller_ocata::params::rabbit_hosts, }
 #  do_config { 'neutron_rabbit_ha_queues': conf_file => '/etc/neutron/neutron.conf', section => 'oslo_messaging_rabbit', param => 'rabbit_ha_queues', value => $controller_ocata::params::rabbit_ha_queues, }

       do_config { 'neutron_lock_path': conf_file => '/etc/neutron/neutron.conf', section => 'oslo_concurrency', param => 'lock_path', value => $controller_ocata::params::neutron_lock_path, }

   do_config { 'neutron_auth_uri': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'auth_uri', value => $controller_ocata::params::auth_uri, }   
   do_config { 'neutron_auth_url': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'neutron_auth_type': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'neutron_project_domain_name': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'neutron_user_domain_name': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'neutron_project_name': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'neutron_username': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'username', value => $controller_ocata::params::neutron_username, }
   do_config { 'neutron_password': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'password', value => $controller_ocata::params::neutron_password, }
   do_config { 'neutron_cafile': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'cafile', value => $controller_ocata::params::cafile, }
   do_config { 'neutron_memcached_servers': conf_file => '/etc/neutron/neutron.conf', section => 'keystone_authtoken', param => 'memcached_servers', value => $controller_ocata::params::memcached_servers, }

   do_config { 'neutron_nova_auth_url': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'auth_url', value => $controller_ocata::params::auth_url, }
   do_config { 'neutron_nova_auth_type': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'auth_type', value => $controller_ocata::params::auth_type, }
   do_config { 'neutron_nova_project_domain_name': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'project_domain_name', value => $controller_ocata::params::project_domain_name, }
   do_config { 'neutron_nova_user_domain_name': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'user_domain_name', value => $controller_ocata::params::user_domain_name, }
   do_config { 'neutron_nova_region_name': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'region_name', value => $controller_ocata::params::region_name, }
   do_config { 'neutron_nova_project_name': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'project_name', value => $controller_ocata::params::project_name, }
   do_config { 'neutron_nova_username': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'username', value => $controller_ocata::params::nova_username, }
   do_config { 'neutron_nova_password': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'password', value => $controller_ocata::params::nova_password, }
   do_config { 'neutron_nova_cafile': conf_file => '/etc/neutron/neutron.conf', section => 'nova', param => 'cafile', value => $controller_ocata::params::cafile, }



#
# Setting di quote di default per nuovi progetti, in modo da non dare la possibilita` di creare nuove reti, nuovi
# router
# Quota 0 per FIP
#
   do_config { 'neutron_quota_network': conf_file => '/etc/neutron/neutron.conf', section => 'quotas', param => 'quota_network', value => $controller_ocata::params::quota_network, }
   do_config { 'neutron_quota_subnet': conf_file => '/etc/neutron/neutron.conf', section => 'quotas', param => 'quota_subnet', value => $controller_ocata::params::quota_subnet, }
   do_config { 'neutron_quota_port': conf_file => '/etc/neutron/neutron.conf', section => 'quotas', param => 'quota_port', value => $controller_ocata::params::quota_port, }
   do_config { 'neutron_quota_router': conf_file => '/etc/neutron/neutron.conf', section => 'quotas', param => 'quota_router', value => $controller_ocata::params::quota_router, }
   do_config { 'neutron_quota_floatingip': conf_file => '/etc/neutron/neutron.conf', section => 'quotas', param => 'quota_floatingip', value => $controller_ocata::params::quota_floatingip, }


   # ml2_conf.ini

   do_config { 'ml2_type_drivers': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ml2', param => 'type_drivers', value => $controller_ocata::params::ml2_type_drivers, }
   do_config { 'ml2_tenant_network_types': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ml2', param => 'tenant_network_types', value => $controller_ocata::params::ml2_tenant_network_types, }
   do_config { 'ml2_mechanism_drivers': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ml2', param => 'mechanism_drivers', value => $controller_ocata::params::ml2_mechanism_drivers, }

   do_config { 'ml2_tunnel_id_ranges': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ml2_type_gre', param => 'tunnel_id_ranges', value => $controller_ocata::params::ml2_tunnel_id_ranges, }

   do_config { 'ml2_tunnel_types': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'agent', param => 'tunnel_types', value => $controller_ocata::params::ml2_tunnel_types, }

       do_config { 'ml2_enable_security_group': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'securitygroup', param => 'enable_security_group', value => $controller_ocata::params::ml2_enable_security_group, }
   do_config { 'ml2_enable_ipset': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'securitygroup', param => 'enable_ipset', value => $controller_ocata::params::ml2_enable_ipset, }

#######
   do_config { 'ml2_flat_networks': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ml2_type_flat', param => 'flat_networks', value => $controller_ocata::params::ml2_flat_networks, }

   do_config { 'ml2_local_ip': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ovs', param => 'local_ip', value => $controller_ocata::params::ml2_local_ip, }
   do_config { 'ml2_bridge_mappings': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ovs', param => 'bridge_mappings', value => $controller_ocata::params::ml2_bridge_mappings, }

###### 
   
$cloud_role= $compute_ocata::params::cloud_role

       if $cloud_role == "is_production" { do_config { 'ml2_network_vlan_ranges': conf_file => '/etc/neutron/plugins/ml2/ml2_conf.ini', section => 'ovs', param => 'network_vlan_ranges', value => $controller_ocata::params::ml2_network_vlan_ranges, }
                                         }
              
  # openvswitch_agent.ini

   do_config { 'ovs_tunnel_types': conf_file => '/etc/neutron/plugins/ml2/openvswitch_agent.ini', section => 'agent', param => 'tunnel_types', value => $controller_ocata::params::ml2_tunnel_types, }
   do_config { 'ovs_local_ip': conf_file => '/etc/neutron/plugins/ml2/openvswitch_agent.ini', section => 'ovs', param => 'local_ip', value => $controller_ocata::params::ml2_local_ip, }
   do_config { 'ovs_bridge_mappings': conf_file => '/etc/neutron/plugins/ml2/openvswitch_agent.ini', section => 'ovs', param => 'bridge_mappings', value => $controller_ocata::params::ml2_bridge_mappings, }
   do_config { 'ovs_enable_tunneling': conf_file => '/etc/neutron/plugins/ml2/openvswitch_agent.ini', section => 'ovs', param => 'enable_tunneling', value => $controller_ocata::params::ovs_enable_tunneling, }
       
   do_config { 'ovs_firewall_driver': conf_file => '/etc/neutron/plugins/ml2/openvswitch_agent.ini', section => 'securitygroup', param => 'firewall_driver', value => $controller_ocata::params::ml2_firewall_driver, } 

# l3_agent.ini

   do_config { 'l3_interface_driver': conf_file => '/etc/neutron/l3_agent.ini', section => 'DEFAULT', param => 'interface_driver', value => $controller_ocata::params::interface_driver, }
   do_config { 'l3_external_network_bridge': conf_file => '/etc/neutron/l3_agent.ini', section => 'DEFAULT', param => 'external_network_bridge', value => $controller_ocata::params::l3_external_network_bridge, }
   do_config { 'l3_gateway_external_network_id': conf_file => '/etc/neutron/l3_agent.ini', section => 'DEFAULT', param => 'gateway_external_network_id', value => $controller_ocata::params::l3_gateway_external_network_id, }



# dhcp_agent.ini

   do_config { 'dhcp_interface_driver': conf_file => '/etc/neutron/dhcp_agent.ini', section => 'DEFAULT', param => 'interface_driver', value => $controller_ocata::params::interface_driver, }
   do_config { 'dhcp_driver': conf_file => '/etc/neutron/dhcp_agent.ini', section => 'DEFAULT', param => 'dhcp_driver', value => $controller_ocata::params::dhcp_driver, }


# metadata_agent.ini
####
   do_config { 'metadata_auth_ca_cert': conf_file => '/etc/neutron/metadata_agent.ini', section => 'DEFAULT', param => 'auth_ca_cert', value => $controller_ocata::params::cafile, }
   do_config { 'metadata_ip': conf_file => '/etc/neutron/metadata_agent.ini', section => 'DEFAULT', param => 'nova_metadata_ip', value => $controller_ocata::params::vip_mgmt, }
   do_config { 'metadata_metadata_proxy_shared_secret': conf_file => '/etc/neutron/metadata_agent.ini', section => 'DEFAULT', param => 'metadata_proxy_shared_secret', value => $controller_ocata::params::metadata_proxy_shared_secret, }
#######Proxy headers parsing
do_config { 'neutron_enable_proxy_headers_parsing': conf_file => '/etc/neutron/neutron.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }

################

 file {'/etc/neutron/plugin.ini':
              ensure      => link,
              target      => '/etc/neutron/plugins/ml2/ml2_conf.ini',
          }



  # Disable useless OVS loggin in secure file
file_line { '/etc/sudoers.d/neutron  syslog':
           path   => '/etc/sudoers.d/neutron',
           line   => 'Defaults:neutron !requiretty, !syslog',
           match  => 'Defaults:neutron',
          }

}
