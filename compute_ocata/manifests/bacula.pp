class compute_ocata::bacula {

include compute_ocata::params

   $baculapackages = [ "bacula-client" ]
  
     package { $baculapackages: ensure => "installed" }
  
    
     service { "bacula-fd":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        require => Package["bacula-client"],
      }


}
