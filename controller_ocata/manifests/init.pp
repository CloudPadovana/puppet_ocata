class controller_ocata ($cloud_role_foreman = "undefined") {

  $cloud_role = $cloud_role_foreman

  $ocatapackages = [ "openstack-utils",

                   ]


     package { $ocatapackages: ensure => "installed" }
  ### yum install centos-release-openstack-ocata

  # Install CA
  class {'controller_ocata::install_ca_cert':}

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

  # Configure ceilometer
  class {'controller_ocata::configure_horizon':}

  # Configure Shibboleth if AII and Shibboleth are enabled
  if ($::controller_ocata::params::enable_aai_ext and $::controller_ocata::params::enable_shib)  {
    class {'controller_ocata::configure_shibboleth':}
  }

  # Configure OpenIdc if AII and openidc are enabled
  if ($::controller_ocata::params::enable_aai_ext and $::controller_ocata::params::enable_oidc)  {
    class {'controller_ocata::configure_openidc':}
  }
 
  # Service
  class {'controller_ocata::service':}

  
  # do passwdless access
  class {'controller_ocata::pwl_access':}
  
  
  # configure remote syslog
  class {'controller_ocata::rsyslog':}
  
  

#      Class['controller_ocata::firewall'] -> Class['controller_ocata::configure_glance']
       Class['controller_ocata::install_ca_cert'] -> Class['controller_ocata::configure_keystone']
       Class['controller_ocata::configure_keystone'] -> Class['controller_ocata::configure_glance']
       Class['controller_ocata::configure_glance'] -> Class['controller_ocata::configure_nova']
       Class['controller_ocata::configure_nova'] -> Class['controller_ocata::configure_neutron']
       Class['controller_ocata::configure_neutron'] -> Class['controller_ocata::configure_cinder']
       Class['controller_ocata::configure_cinder'] -> Class['controller_ocata::configure_horizon']
       Class['controller_ocata::configure_horizon'] -> Class['controller_ocata::configure_heat']
       Class['controller_ocata::configure_heat'] -> Class['controller_ocata::configure_ceilometer']
       if ($enable_aai_ext and $enable_shib)  {
          Class['controller_ocata::configure_ceilometer'] -> Class['controller_ocata::configure_shibboleth']
       }
       if ($enable_aai_ext and $enable_oidc) {
          Class['controller_ocata::configure_ceilometer'] -> Class['controller_ocata::configure_openidc']
       }
       # Class['controller_ocata::configure_neutron'] -> Class['controller_ocata::configure_ceilometer']
       Class['controller_ocata::configure_ceilometer'] -> Class['controller_ocata::service']
            

  }
