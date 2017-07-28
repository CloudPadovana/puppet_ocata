class compute_ocata::libvirt {

   $libvirtpackages = [ "libvirt" ]
  
     package { $libvirtpackages: ensure => "installed" }
  
    
     service { "libvirtd":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        require => Package["libvirt"],
      }

      file_line { '/etc/libvirt/libvirtd.conf listen_tls':
        path   => '/etc/libvirt/libvirtd.conf',
        line   => 'listen_tls = 0',
        match  => 'listen_tls =',
        notify => Service['libvirtd'],
      }

      file_line { '/etc/libvirt/libvirtd.conf listen_tcp':
        path   => '/etc/libvirt/libvirtd.conf',
        line   => 'listen_tcp = 1',
        match  => 'listen_tcp =',
        notify => Service['libvirtd'],
      }

      file_line { '/etc/libvirt/libvirtd.conf auth_tcp':
        path   => '/etc/libvirt/libvirtd.conf',
        line   => 'auth_tcp = "none"',
        match  => 'auth_tcp =',
        notify => Service['libvirtd'],
      }

      file_line { '/etc/sysconfig/libvirtd libvirtd args':
        path  => '/etc/sysconfig/libvirtd',
        line  => 'LIBVIRTD_ARGS="--listen"',
        match => 'LIBVIRTD_ARGS=',
      }

      file_line { '/etc/libvirt/qemu.conf user':
        path  => '/etc/libvirt/qemu.conf',
        line  => 'user = "nova"',
        match => '^user =',
      }

      file_line { '/etc/libvirt/qemu.conf group':
        path  => '/etc/libvirt/qemu.conf',
        line  => 'group = "nova"',
        match => 'group =',
      }

      file_line { '/etc/libvirt/qemu.conf dynamic_ownership':
        path  => '/etc/libvirt/qemu.conf',
        line  => 'dynamic_ownership = 0',
        match => 'dynamic_ownership = ',
      }

      Package['libvirt'] -> File_line<| path == '/etc/libvirt/libvirtd.conf' |>
      Package['libvirt'] -> File_line<| path == '/etc/sysconfig/libvirtd' |>
      Package['libvirt'] -> File_line<| path == '/etc/libvirt/qemu.conf' |>

}
