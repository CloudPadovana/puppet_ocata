#class compute_ocata::params {
class compute_ocata::params ($cloud_role) {
########creando la classe cloud_prod con parametro cloud_role posso introdurre la condizione production, test o qualunque altro tipo di cloud semplicemente sovrascrivendo via foreman il valore della variabile. Qui andrebbe ovviamente inserito un if per ogni tipo di cloud utilizzata con i parametri caratteristici della cloud

####
#  $approved_role = [
#    'is_test',
#    'is_prod_sharedstorage',
#    'is_prod_localstorage'
#  ]

#  validate_string($cloud_role, $approved_role)

###


 if $cloud_role == "is_prod_localstorage" or $cloud_role == "is_prod_sharedstorage" {

   ### Setting per la cloud di produzione
  $auth_uri = ''
  $auth_url = ''
  $ceilometer_auth_url = ''      
  $ceilometer_password = ''   
  $glance_api_servers   = ''   
  $libvirt_rbd_key = ''
  $libvirt_rbd_secret_uuid = ''
  $libvirt_rbd_user = ''
  $memcached_servers    = ''
  $neutron_password   = ''
  $neutron_url          = ''        
  $novncproxy_base_url = 'https://xxxxxx:6080/vnc_auto.html'
  $nova_password  = ''
  $private_key          = 'id_rsa_ctrl-01'     
  $project_name         = 'services'
  $pub_key              = "ssh-rsa "
  $volume_glusterfs     = 'volume-nova-prod'    
                                     }  

 if $cloud_role == "is_test" {
   ### Setting per la cloud di test
  $auth_uri = 'xxxx:5000'
  $auth_url = 'xxxx:35357'
  $ceilometer_auth_url = 'http://xxxx:5000/v3'       
  $ceilometer_password = ''       
  $glance_api_servers   = 'http://xxxx:9292'
####per ceph
  $libvirt_rbd_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx=='
  $libvirt_rbd_secret_uuid = ''
  $libvirt_rbd_user = 'cinder-cloudtest'
  $memcached_servers    = 'x'
  $neutron_password   = ''
  $neutron_url          = ''          
  $novncproxy_base_url = 'https://xxxxx:6080/vnc_auto.html'
  $nova_password  = 'NOVA_PASS'
  $placement_auth_url = 'http://xxxxxx:35357/v3'
  $placement_username = 'placement'
  $placement_password = ''
  $private_key          = 'id_rsa_controller-01'
  $project_name         = 'service'
  $pub_key              = "ssh-rsa "       
###transport url in ocata al posto di rabbit hosts
  $transport_url = 'rabbit://openstack:'   
###aggiunto anche
  $nova_enabled_apis = 'osapi_compute,metadata'
      
                              }

   ### Setting validi sia per la cloud di test che per quella di produzione
  
  ####nel file della guida non trovo allow resize e gli altri param commentati    
  
  $allow_resize            = true     
  $allow_overlapping_ips   = true
  $auth_strategy = 'keystone'
  $auth_type = 'password'
  $cafile                  = '/etc/grid-security/certificates/cafile.pem'
  $ceilometer_interface = 'internalURL'       
  $ceilometer_username   = 'ceilometer'       
  $core_plugin = 'ml2'
  #$cpu_allocation_ratio    = '4.0'
  
  ###cpu e ram allocation per cld-np-09
   if $::mgmt_ip == "" {
        $cpu_allocation_ratio    = '1.0'
        $ram_allocation_ratio    = '1.0'
        }
    else {         
         $cpu_allocation_ratio    = '4.0'
         $ram_allocation_ratio    = '1.5'
         }
  $enable_ipset            = true
  $enable_security_group   = true
  $enable_tunneling        = true       
  #Per distinguere local o shared storage per i compute posso aggiungere una variabile se localstorage if $cloud_strg == "is_local" o "is_shared"    
  if $cloud_role == "is_prod_localstorage" or $cloud_role == "is_test" {
  $libvirt_cpu_mode        = 'host-passthrough'
                                }
  if $cloud_role == "is_prod_sharedstorage" {
  $libvirt_cpu_mode        = 'custom'
  $libvirt_cpu_model       = 'kvm64'
                                }  
  $libvirt_inject_key      = true
  $libvirt_inject_part     = '-1'     
  $libvirt_inject_pass     = true       
  #$linuxnet_int_driver     = 'nova.network.linux_net.LinuxOVSInterfaceDriver'
  #$live_migration_flag     = 'VIR_MIGRATE_UNDEFINE_SOURCE,VIR_MIGRATE_PEER2PEER,VIR_MIGRATE_LIVE'
  $mechanism_drivers       = 'openvswitch'       
  $my_ip = $::mgmt_ip
  $neutron_firewall_driver = 'neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver'       
  $neutron_lock_path               = '/var/lib/neutron/tmp'       
  $neutron_username      = 'neutron'       
  $nova_firewall_driver    = 'nova.virt.firewall.NoopFirewallDriver'
  $nova_instance_usage_audit = true
  $nova_instance_usage_audit_period = 'hour'
  $nova_notification_driver = 'messagingv2'
  $nova_notify_on_state_change = 'vm_and_task_state'       
  $nova_lock_path               = '/var/lib/nova/tmp'
  $nova_username         = 'nova'     
  $nova_use_neutron = true
  $ovs_local_ip            = $::data_ip       
####aggiunti come da doc aggiornamento a ocata
  $ovs_ovsdb_interface = 'vsctl'
  $ovs_of_interface = 'ovs-ofctl'
###
  $project_domain_name = 'default'
  $region_name             = 'regionOne'       
  $service_plugins         = 'router'
  $tenant_network_types    = 'gre'
  $tunnel_id_ranges        = '1:1000'
  $tunnel_types            = 'gre'       
  $type_drivers            = 'flat,vlan,gre,vxlan'       
  $user_domain_name = 'default'
  $vncserver_listen = '0.0.0.0'
  $vnc_enabled = true
  $project_domain_id = 'default'
  $user_domain_id = 'default'
  

}  

