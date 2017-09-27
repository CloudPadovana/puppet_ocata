class controller_ocata::service {
  

  # Ceph
#  class {'controller_ocata::ceph':}
  
  # Configure keystone
#  class {'controller_ocata::configure_keystone':}
  
  # Configure glance
#  class {'controller_ocata::configure_glance':}

  # Configure nova
#  class {'controller_ocata::configure_nova':}

  # Configure ec2
#  class {'controller_ocata::configure_ec2':}

  # Configure neutron
#  class {'controller_ocata::configure_neutron':}

  # Configure cinder
#  class {'controller_ocata::configure_cinder':}

  # Configure heat
#  class {'controller_ocata::configure_heat':}

  # Configure ceilometer
#  class {'controller_ocata::configure_ceilometer':}

  # do passwdless access
#  class {'controller_ocata::pwl_access':}
  
  
  # configure remote syslog
#  class {'controller_ocata::rsyslog':}
  
  
#   file {'INFN-CA.pem':
#                   source      => 'puppet:///modules/controller_ocata/INFN-CA.pem',
#                   path        => '/etc/grid-security/certificates/INFN-CA.pem',
#         }

 ## Services

 service { "memcached":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
           }

 service { "fetch-crl-cron":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
           }

         
 # Services for keystone       
    service { "httpd":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_keystone'],
           }

 # Services for Glance
    service { "openstack-glance-api":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_glance'],
           }
    service { "openstack-glance-registry":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_glance'],
            }

 # Services for nova       
    service { "openstack-nova-api":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_nova'],
           }
    service { "openstack-nova-consoleauth":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_nova'],
           }
    service { "openstack-nova-scheduler":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_nova'],
           }
    service { "openstack-nova-novncproxy":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_nova'],
           }
    service { "openstack-nova-conductor":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_nova'],
           }
    service { "openstack-nova-cert":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_nova'],
           }
            
 # Services for ec2       
    service { "openstack-ec2-api":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_ec2'],
           }
    service { "openstack-ec2-api-metadata":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_ec2'],
           }

 # Services for neutron       
    service { "openvswitch":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_neutron'],
           }
    service { "neutron-server":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_neutron'],
           }
    service { "neutron-openvswitch-agent":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_neutron'],
           }
    service { "neutron-dhcp-agent":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_neutron'],
           }
    service { "neutron-metadata-agent":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_neutron'],
           }
    service { "neutron-l3-agent":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_neutron'],
           }

 # Services for cinder
    service { "openstack-cinder-api":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_cinder'],
           }
    service { "openstack-cinder-scheduler":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_cinder'],
           }
    service { "openstack-cinder-volume":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_cinder'],
           }
    service { "target":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_cinder'],
           }
           
 # Services for heat
    service { "openstack-heat-api":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_heat'],
           }
    service { "openstack-heat-api-cfn":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_heat'],
           }
    service { "openstack-heat-engine":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_heat'],
           }
           
 # Services for ceilometer
    service { "openstack-ceilometer-api":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_ceilometer'],
           }
    service { "openstack-ceilometer-notification":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_ceilometer'],
            }          
    service { "openstack-ceilometer-central":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_ceilometer'],
           }
    service { "openstack-ceilometer-collector":
                   ensure      => running,
                   enable      => true,
                   hasstatus   => true,
                   hasrestart  => true,
                   subscribe   => Class['controller_ocata::configure_ceilometer'],
           }

  }
