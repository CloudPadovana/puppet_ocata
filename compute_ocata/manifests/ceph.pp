class compute_ocata::ceph inherits compute_ocata::params {

     yumrepo { "ceph":
                 baseurl             => "http://download.ceph.com/rpm-luminous/el7/$::architecture/",
                 descr               => "Ceph packages for $::architecture",
                 enabled             => 1,
                 gpgcheck            => 1,
                 gpgkey              => 'https://download.ceph.com/keys/release.asc',
              }
      yumrepo { "ceph-noarch":
                 baseurl             => "http://download.ceph.com/rpm-luminous/el7/noarch",
                 descr               => "Ceph packages for noarch",
                 enabled             => 1,
                 gpgcheck            => 1,
                 gpgkey              => 'https://download.ceph.com/keys/release.asc',
              }

      package { 'ceph-common':
                 ensure => 'installed',
                 require => [ Yumrepo["ceph-noarch"], Yumrepo["ceph"] ]
              }
                                                            
      file {'ceph.conf':
              source      => 'puppet:///modules/compute_ocata/ceph.conf',
              path        => '/etc/ceph/ceph.conf',
              backup      => true,
              require => Package["ceph-common"],
           }

      file {'secret.xml':
             path        => '/etc/nova/secret.xml',
             backup      => true,
             content  => template('compute_ocata/secret.erb'),
             require => Package["openstack-nova-common"],
           }

      $cm = '/usr/bin/virsh secret-define --file /etc/nova/secret.xml | /usr/bin/awk \'{print $2}\' | sed \'/^$/d\' > /etc/nova/virsh.secret'
           
      exec { 'get-or-set virsh secret':
              command => $cm,
              unless  => "/usr/bin/virsh secret-list | grep -i $compute_ocata::params::libvirt_rbd_secret_uuid",
              require => File['secret.xml'],
            }

            
      exec { 'set-secret-value virsh':
          command => "/usr/bin/virsh secret-set-value --secret $compute_ocata::params::libvirt_rbd_secret_uuid --base64 $compute_ocata::params::libvirt_rbd_key",
        unless  => "/usr/bin/virsh secret-get-value $compute_ocata::params::libvirt_rbd_secret_uuid | grep $compute_ocata::params::libvirt_rbd_key",
        require => Exec['get-or-set virsh secret'],
           }
              
}
