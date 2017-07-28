class controller_ocata::ceph {

  
      yumrepo { "ceph":
                 baseurl             => "http://download.ceph.com/rpm-jewel/el7/$::architecture/",
                 descr               => "Ceph packages for $::architecture",
                 enabled             => 1,
                 gpgcheck            => 1,
                 gpgkey              => 'https://download.ceph.com/keys/release.asc',
              }
      yumrepo { "ceph-noarch":
                 baseurl             => "http://download.ceph.com/rpm-jewel/el7/noarch",
                 descr               => "Ceph packages for noarch",
                 enabled             => 1,
                 gpgcheck            => 1,
                 gpgkey              => 'https://download.ceph.com/keys/release.asc',
              }

      package { 'ceph-common':
                 ensure => 'installed',
                 require => [ Yumrepo["ceph-noarch"], Yumrepo["ceph"] ]
              }
####ceph.conf, ceph.client.cinder ceph.client.glance keyring file are in /controller_ocata/files dir
                                                            
      file {'ceph.conf':
              source      => 'puppet:///modules/controller_ocata/ceph.conf',
              path        => '/etc/ceph/ceph.conf',
              backup      => true,
           }

$cloud_role= $compute_ocata::params::cloud_role
if $cloud_role == "is_production" {

      file {'cinder-prod.keyring':
              source      => 'puppet:///modules/controller_ocata/ceph.client.cinder-prod.keyring',
              path        => '/etc/ceph/ceph.client.cinder-prod.keyring',
              backup      => true,
              owner   => cinder,
              group   => cinder,
              mode    => 0640,
           }

      file {'glance-prod.keyring':
              source      => 'puppet:///modules/controller_ocata/ceph.client.glance-prod.keyring',
              path        => '/etc/ceph/ceph.client.glance-prod.keyring',
              backup      => true,
              owner   => glance,
              group   => glance,
              mode    => 0640,
           }

      }                          
      
if $cloud_role == "is_test" {

      file {'cinder-cloudtest.keyring':
              source      => 'puppet:///modules/controller_ocata/ceph.client.cinder-cloudtest.keyring',
              path        => '/etc/ceph/ceph.client.cinder-cloudtest.keyring',
              backup      => true,
              owner   => cinder,
              group   => cinder,
              mode    => 0640,
           }

      file {'glance-test.keyring':
              source      => 'puppet:///modules/controller_ocata/ceph.client.glance-cloudtest.keyring',
              path        => '/etc/ceph/ceph.client.glance-cloudtest.keyring',
              backup      => true,
              owner   => glance,
              group   => glance,
              mode    => 0640,
           }

      }                 
  } 
