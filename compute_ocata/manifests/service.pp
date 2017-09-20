class compute_ocata::service {
#inherits compute_ocata::params {

# include compute_ocata::params


# Services needed

       service { "openvswitch":
                        ensure      => running,
                        enable      => true,
                        hasstatus   => true,
                        hasrestart  => true,
                        require     => Package["openstack-neutron-openvswitch"],
                     #  subscribe   => Class['compute_ocata::neutron'],
               }
              ####invece di configure metto nova o neutron
       service { "neutron-openvswitch-agent":
                        ensure      => running,
                        enable      => true,
                        hasstatus   => true,
                        hasrestart  => true,
                        require     => Package["openstack-neutron-openvswitch"],
                        subscribe   => Class['compute_ocata::neutron'],
               }
       
       service { "neutron-ovs-cleanup":
                        enable      => true,
                        require     => Package["openstack-neutron-openvswitch"],
               }

       service { "messagebus":
                     ensure      => running,
                     enable      => true,
                     hasstatus   => true,
                     hasrestart  => true,
                     require     => Package["libvirt"],
               }


       service { "openstack-nova-compute":
                    ensure      => running,
                    enable      => true,
                    hasstatus   => true,
                    hasrestart  => true,
                    require     => Package["openstack-nova-compute"],
                    subscribe   => Class['compute_ocata::nova']

               }

        service { "openstack-ceilometer-compute":
                    ensure      => running,
                    enable      => true,
                    hasstatus   => true,
                    hasrestart  => true,
                    require     => Package["openstack-ceilometer-compute"],
                    subscribe   => Class['compute_ocata::ceilometer'],
                }

        exec { 'create_bridge':
                     command     => "ovs-vsctl add-br br-int",
                     unless      => "ovs-vsctl br-exists br-int",
                     require     => Service["openvswitch"],
             }
                            
##$cloud_role = $cloud_role::cloud_role if $cloud_role == "is_local" o "is_shared"

    $cloud_role = $compute_ocata::params::cloud_role 

#$cloud_role= $compute_ocata::cloud_role
##if $cloud_role == "is_local" o "is_shared"
# if $cloud_role == "is_local" or cloud_role ==  "is_shared" {

    if $cloud_role == "is_prod_localstorage" {
                  # mount glusterfs volume

                  file { 'nova-instances':
                            path        => "/var/lib/nova/instances",
                            ensure      => directory,
                            require     => Package["openstack-nova-common"],
                       }
                             }

    if $cloud_role == "is_prod_sharedstorage" {
                  file { 'nova-instances':
                            path        => "/var/lib/nova/instances",
                            ensure      => directory,
                            require     => Package["openstack-nova-common"],
                       }

                  mount { "/var/lib/nova/instances":
                            ensure      => mounted,
                            device      => "$compute_ocata::params::volume_glusterfs_ip:/$compute_ocata::params::volume_glusterfs",
                            atboot      => true,
                            fstype      => "glusterfs",
                            options     => "defaults,log-level=ERROR,_netdev,backup-volfile-servers=$compute_ocata::params::volume_glusterfs_log_ip",
                            require     => [ File["nova-instances"], Package ["glusterfs-fuse"] ]
                        }
    }

}  
