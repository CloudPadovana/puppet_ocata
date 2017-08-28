class controller_ocata::params ($cloud_role){


  if $cloud_role == "is_production" {

   ##########################################
   # Cloud di produzione
   $site_fqdn = "cloud-areapd.pd.infn.it"
   $for_production = true
   $admin_password = ''
   $admin_token = ''
   $auth_uri = 'http://xxx.xxx.xxx.xxx:5000'
   $auth_url = ''http://xxx.xxx.xxx.xxx:35357'
   ######
   $placement_auth_url = ''
   #########
   $ceilometer_connection = ''
   $ceilometer_password = ''
   $ceilometer_service_credentials_auth_url = ''
   $cinder_ceph_rbd_pool = ''
   $cinder_ceph_rbd_secret_uuid = ''
   $cinder_ceph_rbd_user = ''
   $cinder_db = ''
   $cinder_password = ''
   $cinder_public_endpoint = ''
   #$ec2_admin_password = ''
   $ec2_db = ''
   $ec2_password = ''
   $ec2_external_network = ''
   $ec2_keystone_url = ''
   $glance_api_rbd_store_pool = ''
   $glance_api_rbd_store_user = ''
   $glance_api_servers = ''
   $glance_db = ''
   $glance_password = ''
   $keystone_admin_endpoint =  ''
   $keystone_db =  ''
   $keystone_public_endpoint =  ''
   $heat_db = ''
   $heat_metadata_server_url = ''
   $heat_password = ''
   $heat_stack_domain_admin_password = ''
   $heat_waitcondition_server_url = ''
   $memcached_servers = ''
   $metadata_proxy_shared_secret = '' 
   $ml2_network_vlan_ranges = '' 
   $ml2_bridge_mappings = ''
   $neutron_db = ''
   $neutron_password = ''
   $neutron_url = ''
   $nova_api_db = ''
   $nova_cinder_endpoint_template = ''
   $nova_db = ''
   $nova_password = ''
   $private_key = ''
   $project_name = 'services'
   $pub_key = "ssh-rsa "   
   #$rabbit_hosts = ''
   $vip_mgmt = ''
   $vip_pub = ''
########
   $placement_password = ''
   $transport_url = ''
    

   } 
    
   if $cloud_role == "is_test"    {

   ##########################################
   # Cloud di test
   $site_fqdn = "cloud-areapd-test.pd.infn.it"
   $for_production = false
   $admin_password = ''
   $admin_tenant_name = ''
   $admin_token = ''
   $auth_uri = ''
   $auth_url = ''
   ######
   $placement_auth_url = ''
   #########
   $ceilometer_connection = ''
   $ceilometer_service_credentials_auth_url = ''
   $ceilometer_password = ''
   $cinder_db = ''
   $cinder_password = ''  
   $cinder_public_endpoint = ''
#######
   $cinder_ceph_rbd_pool = ''
   $cinder_ceph_rbd_secret_uuid = ''
   $cinder_ceph_rbd_user = ''

#########
   $ec2_password = ''
   $ec2_db = ''
   $ec2_external_network = ''
   $ec2_keystone_url = ''
   $glance_db = ''
   $glance_api_servers = ''
   $glance_password = ''
###ceph
   $glance_api_rbd_store_pool = ''
   $glance_api_rbd_store_user = ''
#### 
   $keystone_admin_endpoint =  ''
   $keystone_db =  ''
   $keystone_public_endpoint =  ''
   $heat_db = ''    
   $heat_metadata_server_url = ''
   $heat_password = ''
   $heat_stack_domain_admin_password = ''
   $heat_waitcondition_server_url = ''
   $memcached_servers = ''
   $metadata_proxy_shared_secret = ''
   $ml2_bridge_mappings = 'external:br-ex'
   $neutron_db = ''
   $neutron_password = ''
   $neutron_url = ''
   $nova_api_db = ''
   $nova_cinder_endpoint_template = ''
   $nova_db = ''
   $nova_password = ''
   $private_key = ''
   $project_name = 'service'
   $pub_key = "ssh-rsa "     
   # $rabbit_hosts = ''  
   $vip_mgmt = ''
   $vip_pub = ''
####
   $placement_password = ''
   $transport_url = ''


   }

   ##########################################
   # Attributi validi sia per la cloud di test che quella di produzione
   $admin_user = 'admin'
   $allow_automatic_dhcp_failover = true
   $auth_plugin = 'password'
   $auth_strategy = 'keystone'
   $auth_type = 'password'
   $cafile = ''
   $ceilometer_default_log_levels='amqp=WARN,amqplib=WARN,boto=WARN,qpid=WARN,sqlalchemy=WARN,suds=INFO,oslo.messaging=INFO,iso8601=WARN,requests.packages.urllib3.connectionpool=WARN,urllib3.connectionpool=WARN,websocket=WARN,requests.packages.urllib3.util.retry=WARN,urllib3.util.retry=WARN,keystonemiddleware=WARN,routes.middleware=WARN,stevedore=WARN,taskflow=WARN,keystoneauth=WARN,oslo.cache=INFO,dogpile.core.dogpile=INFO,ceilometer.hardware.discovery=ERROR,ceilometer.transformer.conversions=ERROR'
   $ceilometer_metering_time_to_live = '6912000'
   $ceilometer_service_credentials_interface = 'internalURL'
   $ceilometer_username = 'ceilometer'
   $ceilometer_verbose = false
####
   $ceilometer_meter_dispatchers = 'database'
   $ceilometer_event_dispatchers = 'database'
####
   $ceph_glance_api_version = '2'
   $ceph_rados_connect_timeout = '-1'
   $ceph_rbd_ceph_conf = '/etc/ceph/ceph.conf'
   $ceph_rbd_flatten_volume_from_snapshot = false
   $ceph_rbd_max_clone_depth = '5'
   $ceph_rbd_store_chunk_size = '4'
   $ceph_volume_backend_name = 'ceph'
   $ceph_volume_driver = 'cinder.volume.drivers.rbd.RBDDriver'
   $ceph_volume_group = 'ceph'
   $cinder_default_volume_type = 'ceph'
   $cinder_enabled_backends = 'ceph,iscsi-infnpd'
   $cinder_glusterfs_shares_config = '/etc/cinder/shares'
   $cinder_iscsi_helper = 'tgtadm'
   ###iscsi params
   $cinder_iscsi_nfs_mount_point_base = '/var/lib/cinder/nfs'
   $cinder_iscsi_shares_config = '/etc/cinder/shares'
   ####
   $cinder_lock_path = '/var/lib/cinder/tmp'
   $cinder_my_ip = $::mgmt_ip
   $cinder_gluster_nas_volume_prov_type = 'thin'
   $cinder_nas_volume_prov_type = 'thin'
   $cinder_notification_driver = 'messagingv2'
   $cinder_username = 'cinder'
   $cinder_verbose = false
   $cinder_volume_driver = 'cinder.volume.drivers.glusterfs.GlusterfsDriver'
   $dhcp_agents_per_network = '2'
   $dhcp_driver = 'neutron.agent.linux.dhcp.Dnsmasq'
   $ec2_user = 'ec2_user'
   $ec2_full_vpc_support = false
   #$ec2_identity_uri = $auth_url
   $ec2_log_file = '/var/log/ec2api/ec2api.log'
   $ec2_my_ip = $vip_mgmt
   $ec2_nova_metadata_ip = $vip_mgmt
   $ec2_verbose = false
   $flavor = 'keystone'
   ##
   ##  $glance_container_formats = 'ami,ari,aki,bare,ovf,ova,docker'
   $glance_image_size_cap = '26843545600'
   $glance_notification_driver = 'messagingv2'
   $glance_api_default_store = 'rbd'
   $glance_api_rbd_store_chunk_size = '8'
   $glance_api_show_image_direct_url = true
   $glance_api_show_multiple_locations = true
   $glance_store = 'file,http,rbd'
   $glance_store_datadir = '/var/lib/glance/images/'
   $glance_username = 'glance'
   $glance_verbose = false
   $gluster_volume_backend_name = 'gluster'
   $gluster_volume_driver = 'cinder.volume.drivers.glusterfs.GlusterfsDriver'
   $gluster_volume_group = 'gluster'
   $heat_clients_keystone_auth_uri = $auth_url
   $heat_endpoint_type = 'publicURL'
   $heat_insecure = true
   $heat_stack_domain_admin = 'heat_domain_admin'
   $heat_stack_user_domain_name = 'heat'
   $heat_username = 'heat'
   $heat_verbose = false
##################
   $enable_proxy_headers_parsing = true
##################
   $interface_driver = 'neutron.agent.linux.interface.OVSInterfaceDriver'
#####iscsi params
   $iscsi_volume_backend_name = 'iscsi-infnpd'
   $iscsi_volume_driver = 'cinder.volume.drivers.nfs.NfsDriver'
   $iscsi_volume_group = 'iscsi-infnpd'
#####
   $keystone_verbose = false
   $keystone_token_provider = 'fernet'
   $l3_external_network_bridge = ''
   $l3_gateway_external_network_id = ''
   $ml2_enable_ipset = true
   $ml2_enable_security_group = true
   $ml2_firewall_driver = 'neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver'
   $ml2_flat_networks = '*'
   $ml2_local_ip = $::data_ip
   $ml2_mechanism_drivers = 'openvswitch'
   $ml2_tenant_network_types = 'gre'
   $ml2_tunnel_id_ranges = '1:1000'
   $ml2_tunnel_types = 'gre'
   $ml2_type_drivers = 'gre,flat,vlan,vxlan'
   $neutron_allow_automatic_l3agent_failover = true
   $neutron_allow_overlapping_ips = true
   $neutron_core_plugin = 'ml2'
   $neutron_l3_ha = true
   $neutron_lock_path = '/var/lib/neutron/tmp'
   $neutron_max_l3_agents_per_router = '2'
   $neutron_min_l3_agents_per_router = '2'
   $neutron_notify_nova_on_port_data_changes = true
   $neutron_notify_nova_on_port_status_changes = true
   $neutron_service_plugins = 'router'
   $neutron_username = 'neutron'
   $neutron_verbose = false
   $nova_cinder_catalog_info = 'volumev2:cinderv2:internalURL'
   $nova_cpu_allocation_ratio = '4.0'
   $nova_default_schedule_zone = 'nova'
   $nova_firewall_driver = 'nova.virt.firewall.NoopFirewallDriver'
   $nova_inject_key = true
   $nova_inject_partition = '-1'
   $nova_inject_password = true
   $nova_oslo_lock_path = '/var/lib/nova/tmp'
   $nova_scheduler_max_attempts = '10'
   $nova_host_subset_size = '10'
   $nova_username = 'nova'
   $nova_verbose = false
   $ovs_enable_tunneling = true
   $ovs_l2_population = true
   $project_domain_name = 'default'
   $quota_network = '1'
   $quota_subnet = '1'
   $quota_port = '51'
   $quota_router = '0'
   $quota_floatingip = '0'
   $region_name = 'regionOne'
   #$scheduler_default_filters e' stato sostituito con enabled_filters
   $enabled_filters   = 'AggregateInstanceExtraSpecsFilter,AggregateMultiTenancyIsolation,RetryFilter,AvailabilityZoneFilter,RamFilter,CoreFilter,AggregateRamFilter,AggregateCoreFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter'
   $service_metadata_proxy = true
   $token_expiration = '32400'
   $user_domain_name = 'default'
   $use_neutron = true
####
   $vnc_enabled = true
   $placement_username = 'placement'
   $enabled_apis = 'osapi_compute,metadata'
   
  ############################################################################
  #  Security params
  ############################################################################

  $host_cert = "/etc/grid-security/hostcert.pem"
  $host_key = "/etc/grid-security/hostkey.pem"
  $ca_file = "/etc/grid-security/certificates/INFN-CA-2015.pem"
  $crl_file_list = [ "/etc/grid-security/certificates/49f18420.r0" ]

  ############################################################################
  #  AAI estensions
  ############################################################################
  
  $enable_aai_ext = false

  ############################################################################
  #  Shibboleth params
  ############################################################################

  $enable_shib = true
  $shib_repo_url = "http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo"
  $shib_info_url = "http://wiki.infn.it/progetti/cloud-areapd/home"
  
  if $for_production {
    $infnaai_ent_id = "https://idp.infn.it/saml2/idp/metadata.php"
  } else {
    $infnaai_ent_id = "https://idp.infn.it/testing/saml2/idp/metadata.php"
  }

  ############################################################################
  #  OpenID Connect params
  ############################################################################

  $enable_oidc = false
  $oidc_repo_url = "http://igi-01.pd.infn.it/mrepo/CAP/misc-centos7.repo"
  $oidc_passphrase = ""
  
  $indigo_md_url = "https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration"
  $indigo_client_id = ""
  $indigo_secret = ""

}
