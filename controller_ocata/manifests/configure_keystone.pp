class controller_ocata::configure_keystone inherits controller_ocata::params {

#
# Questa classe:
# - popola il file /etc/keystone/keystone.conf
# - crea il file /etc/httpd/conf.d/wsgi-keystone.conf
#
  
define do_config ($conf_file, $section, $param, $value) {
             exec { "${name}":
                              command     => "/usr/bin/openstack-config --set ${conf_file} ${section} ${param} \"${value}\"",
                              require     => Package['openstack-utils'],
                              unless      => "/usr/bin/openstack-config --get ${conf_file} ${section} ${param} 2>/dev/null | /bin/grep -- \"^${value}$\" 2>&1 >/dev/null",
                  }
       }

define remove_config ($conf_file, $section, $param, $value) {
             exec { "${name}":
                              command     => "/usr/bin/openstack-config --del ${conf_file} ${section} ${param}",
                              require     => Package['openstack-utils'],
                              onlyif      => "/usr/bin/openstack-config --get ${conf_file} ${section} ${param} 2>/dev/null | /bin/grep -- \"^${value}$\" 2>&1 >/dev/null",
                   }
       }
                                                                                                                                             
define do_augeas_config ($conf_file, $section, $param) {
  $split = split($name, '~')
  $value = $split[-1]
  $index = $split[-2]

  augeas { "augeas/${conf_file}/${section}/${param}/${index}/${name}":
    lens    => "PythonPaste.lns",
    incl    => $conf_file,
    changes => [ "set ${section}/${param}[${index}] ${value}" ],
    onlyif  => "get ${section}/${param}[${index}] != ${value}"
  }
}

define do_config_list ($conf_file, $section, $param, $values) {
  $values_size = size($values)

  # remove the entire block if the size doesn't match
  augeas { "remove_${conf_file}_${section}_${param}":
    lens    => "PythonPaste.lns",
    incl    => $conf_file,
    changes => [ "rm ${section}/${param}" ],
    onlyif  => "match ${section}/${param} size > ${values_size}"
  }

  $namevars = array_to_namevars($values, "${conf_file}~${section}~${param}", "~")

  # check each value
  do_augeas_config { $namevars:
    conf_file => $conf_file,
    section => $section,
    param => $param
  }
}

# keystone.conf
   do_config { 'keystone_admin_token': conf_file => '/etc/keystone/keystone.conf', section => 'DEFAULT', param => 'admin_token', value => $controller_ocata::params::admin_token, }

  do_config { 'keystone_public_endpoint': conf_file => '/etc/keystone/keystone.conf', section => 'DEFAULT', param => 'public_endpoint', value => $controller_ocata::params::keystone_public_endpoint, }
   do_config { 'keystone_admin_endpoint': conf_file => '/etc/keystone/keystone.conf', section => 'DEFAULT', param => 'admin_endpoint', value => $controller_ocata::params::keystone_admin_endpoint, }

   do_config { 'keystone_db': conf_file => '/etc/keystone/keystone.conf', section => 'database', param => 'connection', value => $controller_ocata::params::keystone_db, }

  do_config { 'keystone_token_provider': conf_file => '/etc/keystone/keystone.conf', section => 'token', param => 'provider', value => $controller_ocata::params::keystone_token_provider, }
  do_config { 'keystone_token_expiration': conf_file => '/etc/keystone/keystone.conf', section => 'token', param => 'expiration', value => $controller_ocata::params::token_expiration, }



       
#######Proxy headers parsing
do_config { 'keystone_enable_proxy_headers_parsing': conf_file => '/etc/keystone/keystone.conf', section => 'oslo_middleware', param => 'enable_proxy_headers_parsing', value => $controller_ocata::params::enable_proxy_headers_parsing, }


##  do_config { 'keystone_auth_methods': conf_file => '/etc/keystone/keystone.conf', section => 'auth', param => 'methods', value => $controller_ocata::params::keystone_auth_methods, }



   file { "/usr/share/keystone/wsgi-keystone.conf":
     ensure   => file,
     owner    => "root",
     group    => "root",
     mode     => '0644',
     content  => template("controller_ocata/wsgi-keystone.conf.erb"),
   }

   file { '/etc/httpd/conf.d/wsgi-keystone.conf':
     ensure => link,
     target => '/usr/share/keystone/wsgi-keystone.conf',
   }

  
  ############################################################################
  #  OS-Federation setup
  ############################################################################

  if $enable_aai_ext {

    do_config { 'keystone_auth_methods':
      conf_file => '/etc/keystone/keystone.conf',
      section   => 'auth',
      param     => 'methods',
      value     => 'password,token,mapped,openid',
    }

    do_config_list { "keystone_trusted_dashboards":
      conf_file => '/etc/keystone/keystone.conf',
      section   => 'federation',
      param     => 'trusted_dashboard',
      values    => [ "https://${site_fqdn}/dashboard/auth/websso/", "https://cloudveneto.ict.unipd.it/dashboard/auth/websso/" ],
    }
    
    do_config { "keystone_shib_attr":
      conf_file => '/etc/keystone/keystone.conf',
      section   => 'mapped',
      param     => 'remote_id_attribute',
      value     => 'Shib-Identity-Provider',
    }

    file { "/etc/keystone/policy.json":
      ensure   => file,
      owner    => "keystone",
      group    => "keystone",
      mode     => '0640',
      source  => "puppet:///modules/controller_ocata/policy.json",
    }

    ### Patch for error handling in OS-Federation
    package { "patch":
      ensure  => installed,
    }

    file { "/usr/share/keystone/controllers.patch":
      ensure   => file,
      owner    => "keystone",
      group    => "keystone",
      mode     => '0640',
      source  => "puppet:///modules/controller_ocata/controllers.patch",
    }
    
    exec { "patch-controllers":
      command => "/usr/bin/patch /usr/lib/python2.7/site-packages/keystone/federation/controllers.py /usr/share/keystone/controllers.patch",
      unless  => "/bin/grep Keystone-patch-0001 /usr/lib/python2.7/site-packages/keystone/federation/controllers.py 2>/dev/null >/dev/null",
      require => [ File["/usr/share/keystone/controllers.patch"], Package["patch"] ],
    }
    
    file { "/usr/share/keystone/sso_callback_template.patch":
      ensure   => file,
      owner    => "keystone",
      group    => "keystone",
      mode     => '0640',
      source  => "puppet:///modules/controller_ocata/sso_callback_template.patch",
    }
    
    exec { "patch-sso-callback-template":
      command => "/usr/bin/patch /etc/keystone/sso_callback_template.html /usr/share/keystone/sso_callback_template.patch",
      unless  => "/bin/grep code /etc/keystone/sso_callback_template.html 2>/dev/null >/dev/null",
      require => [ File["/usr/share/keystone/sso_callback_template.patch"], Package["patch"] ],
    }
  }
     
}
