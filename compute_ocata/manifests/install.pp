class compute_ocata::install inherits compute_ocata::params {
#include compute_ocata::params

#$cloud_role = $cloud_role::cloud_role
$cloud_role = $compute_ocata::params::cloud_role          
#$cloud_role= $compute_ocata::cloud_role
#  $computepackages = [ "openstack-nova-compute",
#                         "openstack-utils",
#                         "openstack-neutron-openvswitch",
#                         "openstack-nova-common",
#                         "openstack-neutron-common",
#                         "openstack-neutron-ml2",
#                         "yum-plugin-priorities",
#                         "ipset",
#                         "sysfsutils" ]

### Repository settings (remove old rpm and install new one)
#
  
  define removepackage {
    exec {
        "removepackage_$name":
            command => "/usr/bin/yum -y erase $name",
            onlyif => "/bin/rpm -ql $name";
    }
  }

  $oldrelease = [ 'centos-release-openstack-mitaka',
                  'centos-release-ceph-hammer',
                ]
  $newrelease = 'centos-release-openstack-ocata'

  Removepackage { 
    $oldrelease :
  }

  package { $newrelease :
    ensure => 'installed',
  } 

## Install generic packages
  $genericpackages = [   "openstack-utils",
                         "yum-plugin-priorities",
                         "ipset",
                         "sysfsutils" ]
  package { $genericpackages: ensure => "installed" }


#######
  $neutronpackages = [   "openstack-neutron-openvswitch",
                         "openstack-neutron-common",
                         "openstack-neutron-ml2" ]
  package { $neutronpackages: ensure => "installed" }

  $novapackages = [ "openstack-nova-compute",
                     "openstack-nova-common" ]

  package { $novapackages: ensure => "installed" }
  
  $ceilometerpackages = [ "openstack-ceilometer-compute",
                          "python2-wsme" ]
                           # ,
                           #"python-ceilometerclient",
                           #"python2-pecan" ]
  package { $ceilometerpackages: ensure => "installed" }

#####nella guida di installazione a ocata per i compute sembra non ci siano python-ceilometerclient python2-pecan

#  package { 'glusterfs-fuse': ensure => 'installed' }
         
 # Disable useless OVS loggin in secure file
          file_line { '/etc/sudoers.d/neutron  syslog':
                path   => '/etc/sudoers.d/neutron',
                line   => 'Defaults:neutron !requiretty, !syslog',
                                match  => 'Defaults:neutron',
                    }
 
if $::compute_ocata::cloud_role == "is_prod_localstorage" or $::compute_ocata::cloud_role ==  "is_prod_sharedstorage" {                             
  yumrepo { "glusterfs-epel":
          baseurl=> "http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.4/EPEL.repo/epel-7/$::architecture/",
          descr=> "GlusterFS is a clustered file-system capable of scaling to several petabytes",
          enabled=> 1,
          gpgcheck=> 1,
          gpgkey=> 'http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.4/EPEL.repo/pub.key',
            }

   yumrepo { "glusterfs-noarch-epel":
          baseurl             => "http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.4/EPEL.repo/epel-7/noarch/",
          descr               => "GlusterFS is a clustered file-system capable of scaling to several petabytes",
          enabled             => 1,
          gpgcheck            => 1,
          gpgkey              => 'http://download.gluster.org/pub/gluster/glusterfs/3.7/3.7.4/EPEL.repo/pub.key',
            }

   package { 'glusterfs-fuse':
              ensure => 'installed',
              require => [ Yumrepo["glusterfs-epel"], Yumrepo["glusterfs-noarch-epel"] ]
           }
                                                                                     } ###chiudo if 
}
