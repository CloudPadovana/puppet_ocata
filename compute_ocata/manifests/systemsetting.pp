class compute_ocata::systemsetting {

# inherits compute_ocata::params {

include compute_ocata::params

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

   file {'INFN-CA.pem':
             source      => 'puppet:///modules/compute_ocata/INFN-CA.pem',
             path        => '/etc/grid-security/certificates/INFN-CA.pem',
        }

   package { "ca_TERENA-SSL-CA-3":
             source   => "http://artifacts.pd.infn.it/packages/CAP/misc/CentOS7/noarch/ca_TERENA-SSL-CA-3-1.0-1.el7.centos.noarch.rpm",
             provider => "rpm",
        }
}
