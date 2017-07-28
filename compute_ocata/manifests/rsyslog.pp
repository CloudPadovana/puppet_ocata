class compute_ocata::rsyslog {

  $rsyslogpackages = [ "rsyslog" ]
  
  package { $rsyslogpackages: ensure => "installed" }
  
    
      service { "rsyslog":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        require => Package["rsyslog"],
      }

      file_line { '/etc/rsyslog.conf remotehost':
        path   => '/etc/rsyslog.conf',
        line   => '*.* @@192.168.60.31:514',
        match  => '@@',
        notify => Service['rsyslog'],
      }

       file_line { '/etc/rsyslog.conf imklog':
        path   => '/etc/rsyslog.conf',
        line   => "\$ModLoad imklog # reads kernel messages (the same are read from journald)",
        match  => "imklog",
        notify => Service['rsyslog'],
      }


      
    file {'ignore_nagios':
      source      => 'puppet:///modules/compute_ocata/ignore-systemd-session-slice-nagios.conf',
      path        => '/etc/rsyslog.d/ignore-systemd-session-slice-nagios.conf',
      backup      => true,
      owner   => root,
      group   => root,
      mode    => 0644,
      notify => Service['rsyslog'],
       }
             

  Package['rsyslog'] -> File_line<| path == '/etc/rsyslog.conf' |>

}
