class compute_ocata ($cloud_role_foreman = "undefined") { 

  $cloud_role = $cloud_role_foreman  

  # system check setting (network, selinux, CA files)
    class {'compute_ocata::systemsetting':}

  # install
    class {'compute_ocata::install':}

  # setup firewall
    class {'compute_ocata::firewall':}

  # setup bacula
    class {'compute_ocata::bacula':}
  
  # setup libvirt
    class {'compute_ocata::libvirt':}

  # setup ceph
    class {'compute_ocata::ceph':}

  # setup rsyslog
    class {'compute_ocata::rsyslog':}

  # do configuration
  #  class {'compute_ocata::configure':}

  # service
    class {'compute_ocata::service':}

  # install and configure nova
     class {'compute_ocata::nova':}

  # install and configure neutron
     class {'compute_ocata::neutron':}

  # install and configure ceilometer
     class {'compute_ocata::ceilometer':}

  # nagios settings
     class {'compute_ocata::nagiossetting':}

  # do passwdless access
      class {'compute_ocata::pwl_access':}


# Services needed
######################## questi servizi sono stati splittati nel modulo ::service
#      service { "openvswitch":
#                        ensure      => running,
#                        enable      => true,
#                        hasstatus   => true,
#                        hasrestart  => true,
#                        require     => Package["openstack-neutron-openvswitch"],
#                        subscribe   => Class['compute_ocata::configure'],
#              }
              
#       service { "neutron-openvswitch-agent":
#                        ensure      => running,
#                        enable      => true,
#                        hasstatus   => true,
#                        hasrestart  => true,
#                        require     => Package["openstack-neutron-openvswitch"],
#                        subscribe   => Class['compute_ocata::configure'],
#               }

#       service { "neutron-ovs-cleanup":
#                        enable      => true,
#                        require     => Package["openstack-neutron-openvswitch"],
#               }

#       service { "messagebus":
#                     ensure      => running,
#                     enable      => true,
#                     hasstatus   => true,
#                     hasrestart  => true,
#                     require     => Package["libvirt"],
#                }


#       service { "openstack-nova-compute":
#                    ensure      => running,
#                    enable      => true,
#                    hasstatus   => true,
#                    hasrestart  => true,
#                    require     => Package["openstack-nova-compute"],
#                    subscribe   => Class['compute_ocata::configure'],
#               }

#        service { "openstack-ceilometer-compute":
#                    ensure      => running,
#                    enable      => true,
#                    hasstatus   => true,
#                    hasrestart  => true,
#                    require     => Package["openstack-ceilometer-compute"],
#                    subscribe   => Class['compute_ocata::ceilometer'],
#               }

#       exec { 'create_bridge':
#                     command     => "ovs-vsctl add-br br-int",
#                     unless      => "ovs-vsctl br-exists br-int",
#                     require     => Service["openvswitch"],
#            }
########################################                            

           
# execution order
             #Class['compute_ocata::firewall'] -> Class['compute_ocata::install']
             #Class['compute_ocata::install'] -> Class['compute_ocata::configure']
             #Class['compute_ocata::configure'] -> File['/etc/neutron/plugin.ini']
             #Class['compute_ocata::configure'] -> Cron['nagios_check_ovs']
             #Class['compute_ocata::configure'] -> Cron['nagios_check_kvm']
             #Class['compute_ocata::configure'] -> Class['compute_ocata::pwl_access']
             #Service["openvswitch"] -> Exec['create_bridge']
             Class['compute_ocata::firewall'] ->  Class['compute_ocata::systemsetting']
             Class['compute_ocata::systemsetting'] -> Class['compute_ocata::install']
             Class['compute_ocata::install'] -> Class['compute_ocata::bacula']
             Class['compute_ocata::bacula'] -> Class['compute_ocata::nova']
             Class['compute_ocata::nova'] -> Class['compute_ocata::neutron']
             Class['compute_ocata::neutron'] -> Class['compute_ocata::ceph']
             Class['compute_ocata::neutron'] -> Class['compute_ocata::nagiossetting']
             Class['compute_ocata::neutron'] -> Class['compute_ocata::pwl_access']
             Class['compute_ocata::neutron'] -> Class['compute_ocata::ceilometer']
             Class['compute_ocata::ceilometer'] -> Class['compute_ocata::service']
################           
}
  
