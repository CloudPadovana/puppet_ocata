class controller_ocata::configure_shibboleth inherits controller_ocata::params {

  exec { "download_shib_repo":
    command => "/usr/bin/wget -q -O /etc/yum.repos.d/shibboleth.repo ${shib_repo_url}",
    creates => "/etc/yum.repos.d/shibboleth.repo",
  }
  
  package { "shibboleth":
    ensure  => present,
    require => Exec["download_shib_repo"],
  }
  
  file { "/etc/shibboleth/sp-key.pem":
    ensure   => file,
    owner    => "shibd",
    group    => "shibd",
    mode     => '0400',
    source   => "${host_key}"
    require  => Package["shibboleth"],
  }

  file { "/etc/shibboleth/sp-cert.pem":
    ensure   => file,
    owner    => "shibd",
    group    => "shibd",
    mode     => '0600',
    source   => "${host_cert}"
    require  => Package["shibboleth"],
  }

  file { "/etc/shibboleth/attribute-map.xml":
    ensure   => file,
    owner    => "root",
    group    => "root",
    mode     => '0644',
    source   => "puppet:///modules/controller_ocata/attribute-map.xml"
    require  => Package["shibboleth"],
  }

  file { "/etc/shibboleth/shibboleth2.xml":
    ensure   => file,
    owner    => "shibd",
    group    => "shibd",
    mode     => '0640',
    content  => template("controller_ocata/shibboleth2.xml.erb"),
    require  => Package["shibboleth"],
  }

}
