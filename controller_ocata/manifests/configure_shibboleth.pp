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
    source   => "${host_key}",
    tag      => ["shibboleth_sec"],
  }

  file { "/etc/shibboleth/sp-cert.pem":
    ensure   => file,
    owner    => "shibd",
    group    => "shibd",
    mode     => '0600',
    source   => "${host_cert}",
    tag      => ["shibboleth_sec"],
  }

  file { "/etc/shibboleth/attribute-map.xml":
    ensure   => file,
    owner    => "root",
    group    => "root",
    mode     => '0644',
    source   => "puppet:///modules/controller_ocata/attribute-map.xml",
    tag      => ["shibboleth_conf"],
  }

  file { "/etc/shibboleth/idem-template-metadata.xml":
    ensure   => file,
    owner    => "root",
    group    => "root",
    mode     => '0644',
    content  => template("controller_ocata/idem-template-metadata.xml.erb"),
    tag      => ["shibboleth_conf"],
  }

  file { "/etc/shibboleth/shibboleth2.xml":
    ensure   => file,
    owner    => "shibd",
    group    => "shibd",
    mode     => '0640',
    content  => template("controller_ocata/shibboleth2.xml.erb"),
    tag      => ["shibboleth_conf"],
  }

  service { "shibd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
  }
  
  Package["shibboleth"] -> File <| tag == 'shibboleth_sec' |> ~> Service["shibd"]
  Package["shibboleth"] -> File <| tag == 'shibboleth_conf' |> ~> Service["shibd"]

}
