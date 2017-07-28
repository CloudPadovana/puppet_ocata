class compute_ocata { 

  #include compute_ocata::params
  #$cloud_role = $compute_ocata::params::cloud_role
  # parameter
  # class {'compute_ocata::params':}
  #         cloud_role => " ",
  #       }

  # install
    class {'compute_ocata::install':}

  # setup firewall
    class {'compute_ocata::firewall':}
  
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


  # do passwdless access
      class {'compute_ocata::pwl_access':}

  # disable SELinux
      exec { "setenforce 0":
              path=> "/bin:/sbin:/usr/bin:/usr/sbin",
              onlyif=> "which setenforce && getenforce | grep Enforcing",
           }

   # setup sysctl

    Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin' }
    Sysctl {
            notify      => Exec["load-sysctl"],
            require     => Class['compute_ocata::libvirt'],
           }

     $my_sysctl_settings = {
                            "net.ipv4.conf.all.rp_filter"     => { value => 0 },
                            "net.ipv4.conf.default.rp_filter" => { value => 0 },
                            "net.bridge.bridge-nf-call-arptables" => { value => 1 },
                            "net.bridge.bridge-nf-call-iptables" => { value => 1 },
                            "net.bridge.bridge-nf-call-ip6tables" => { value => 1 }
                           }
       
                           
     create_resources(sysctl::value,$my_sysctl_settings)

     exec { load-sysctl:
                         command     => "/sbin/sysctl -p /etc/sysctl.conf",
                         refreshonly => true
          }
                                                                                      

          
     file {'/etc/neutron/plugin.ini':
              ensure      => link,
              target      => '/etc/neutron/plugins/ml2/ml2_conf.ini',
              require     => Package['openstack-neutron-ml2']
          }

     file {'nagios_check_ovs':
             source      => 'puppet:///modules/compute_ocata/nagios_check_ovs.sh',
             path => '/usr/local/bin/nagios_check_ovs.sh',
             mode => '+x',
             #subscribe   => Class['compute_ocata::neutron'],
          }
####invece di configure sottoscrivo alla classe nova
     file {'nagios_check_kvm':
             source      => 'puppet:///modules/compute_ocata/check_kvm',
             path        => '/usr/local/bin/check_kvm',
             mode        => '+x',
             #subscribe   => Class['compute_ocata::nova'],
          }

     file {'nagios_check_kvm_wrapper':
             source      => 'puppet:///modules/compute_ocata/check_kvm_wrapper.sh',
             path        => '/usr/local/bin/check_kvm_wrapper.sh',
             mode        => '+x',
             require => File['nagios_check_kvm'],
             #subscribe   => Class['compute_ocata::nova'],
          }

     file {'check_total_disksize.sh':
             source      => 'puppet:///modules/compute_ocata/check_total_disksize.sh',
             path        => '/usr/lib64/nagios/plugins/check_total_disksize.sh',
             mode        => '+x',
             #subscribe   => Class['compute_ocata::nova'],
          }

       file {'cafile.pem':
                      source      => 'puppet:///modules/compute_ocata/INFN-CA.pem',
                      path        => '/etc/grid-security/certificates/cafile.pem',
            }
                    

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

                                             
# NAGIOS - various crontabs

                     cron {'nagios_check_ovs':
                                          ensure      => present,
                                          command     => "/usr/local/bin/nagios_check_ovs.sh",
                                          user        => root,
                                          minute      => '*/10',
                                          hour        => '*',
                                          require     => File["nagios_check_ovs"]
                                        }

                      cron {'nagios_check_kvm':
                                          ensure     => present,
                                          command    => "/usr/local/bin/check_kvm_wrapper.sh",
                                          user       => root,
                                          minute      => 0,
                                          hour        => '*/1',
                                          require    => File["nagios_check_kvm_wrapper"]
                           }
                                                                                    
           
# execution order
###### il modulo service viene eseguito dopo l'install dei pacchetti           
             Class['compute_ocata::firewall'] -> Class['compute_ocata::install']
             Class['compute_ocata::install'] -> Class['compute_ocata::nova']
             Class['compute_ocata::nova'] -> Class['compute_ocata::neutron']
            #Class['compute_ocata::configure'] -> File['/etc/neutron/plugin.ini']
             Class['compute_ocata::neutron'] -> Cron['nagios_check_ovs']
             Class['compute_ocata::neutron'] -> Cron['nagios_check_kvm']
             Class['compute_ocata::neutron'] -> Class['compute_ocata::pwl_access']
             Class['compute_ocata::neutron'] -> Class['compute_ocata::ceilometer']
             Class['compute_ocata::ceilometer'] -> Class['compute_ocata::service']
             Service["openvswitch"] -> Exec['create_bridge']
################           
}
  
