class controller_ocata::configure_openidc inherits controller_ocata::params {

  package { "mod_auth_openidc":
    ensure  => present,
  }
  
  file { "/etc/httpd/conf.d/auth_openidc.conf":
    ensure   => file,
    owner    => "apache",
    group    => "apache",
    mode     => '0640',
    content  => template("controller_ocata/openidc.conf.erb"),
    tag      => ["oidc_conf"],
  }

  file { "/var/cache/httpd/mod_auth_openidc":
    ensure  => directory,
    owner   => "apache",
    group   => "apache",
    mode    => '0770',
  }

  file { "/var/cache/httpd/mod_auth_openidc/metadata":
    ensure  => directory,
    owner   => "apache",
    group   => "apache",
    mode    => '0770',
    require => File["/var/cache/httpd/mod_auth_openidc"],
  }
  
  ############################################################################
  #  INDIGO IAM
  ############################################################################

  exec { "download_metadata_indigo":
    command => "/usr/bin/wget -q -O /var/cache/httpd/mod_auth_openidc/metadata/iam-test.indigo-datacloud.eu.provider ${indigo_md_url}",
    creates => "/var/cache/httpd/mod_auth_openidc/metadata/iam-test.indigo-datacloud.eu.provider",
    require => File["/var/cache/httpd/mod_auth_openidc/metadata"],
    tag     => ["oidc_conf"],
  }
  
  file { "/var/cache/httpd/mod_auth_openidc/metadata/iam-test.indigo-datacloud.eu.client":
    ensure   => file,
    owner    => "apache",
    group    => "apache",
    mode     => '0640',
    content  => '{"client_id" : "${indigo_client_id}", "client_secret" : "${indigo_secret}"}\n',
    tag      => ["oidc_conf"],
  }

  file { "/var/cache/httpd/mod_auth_openidc/metadata/iam-test.indigo-datacloud.eu.conf":
    ensure   => file,
    owner    => "apache",
    group    => "apache",
    mode     => '0640',
    content  => '{"scope" : "openid profile email", "token_endpoint_auth" : "client_secret_basic", "response_type" : "code"}\n',
    tag      => ["oidc_conf"],
  }
  
  #
  # TODO missing notification to httpd
  #
  Package["mod_auth_openidc"] -> File <| tag == 'oidc_conf' |>

}
