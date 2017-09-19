class controller_ocata {
  include controller_ocata::params


   $ocatapackages = [ "openstack-utils",

                   ]


     package { $ocatapackages: ensure => "installed" }
  ### yum install centos-release-openstack-ocata


  # Ceph
  class {'controller_ocata::ceph':}
  
  # Configure keystone
  class {'controller_ocata::configure_keystone':}
  
  # Configure glance
  class {'controller_ocata::configure_glance':}

  # Configure nova
  class {'controller_ocata::configure_nova':}

  # Configure ec2
  class {'controller_ocata::configure_ec2':}

  # Configure neutron
  class {'controller_ocata::configure_neutron':}

  # Configure cinder
  class {'controller_ocata::configure_cinder':}

  # Configure heat
  class {'controller_ocata::configure_heat':}

  # Configure ceilometer
  class {'controller_ocata::configure_ceilometer':}
 
  # Service
  class {'controller_ocata::service':}

  
  # do passwdless access
  class {'controller_ocata::pwl_access':}
  
  
  # configure remote syslog
  class {'controller_ocata::rsyslog':}
  
  
   file {'INFN-CA.pem':
                   source      => 'puppet:///modules/controller_ocata/INFN-CA.pem',
                   path        => '/etc/grid-security/certificates/INFN-CA.pem',
         }



#            Class['controller_ocata::firewall'] -> Class['compute_ocata::glance']
             Class['controller_ocata::configure_glance'] -> Class['controller_ocata::configure_nova']
            Class['controller_ocata::configure_nova'] -> Class['controller_ocata::configure_neutron']
             Class['controller_ocata::configure_neutron'] -> Class['controller_ocata::configure_cinder']
             Class['controller_ocata::configure_cinder'] -> Class['controller_ocata::configure_heat']
             Class['controller_ocata::configure_heat'] -> Class['controller_ocata::configure_ceilometer']
            # Class['controller_ocata::configure_neutron'] -> Class['controller_ocata::configure_ceilometer']
             Class['controller_ocata::configure_ceilometer'] -> Class['controller_ocata::service']
            

  }
