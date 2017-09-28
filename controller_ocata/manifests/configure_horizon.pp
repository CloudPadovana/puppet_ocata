class controller_ocata::configure_horizon inherits controller_ocata::params {

  #
  # TODO missing installation of Horizon base (use template wsgi-horizon.conf.erb)
  #
  
  ############################################################################
  #  OS-Federation
  ############################################################################

  exec { "download_cap_repo":
    command => "/usr/bin/wget -q -O /etc/yum.repos.d/openstack-security-integrations.repo ${cap_repo_url}",
    creates => "/etc/yum.repos.d/openstack-security-integrations.repo",
  }

  package { ["openstack-auth-cap", "openstack-auth-shib"]:
    ensure  => latest,
    require => Exec["download_cap_repo"],
  }
  
  file { "/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.d/_1002_aai_settings.py":
    ensure   => file,
    owner    => "root",
    group    => "apache",
    mode     => '0640',
    content  => template("controller_ocata/aai_settings.py.erb"),
  }

  file { "/etc/httpd/conf.d/ssl.conf":
    ensure   => file,
    owner    => "root",
    group    => "root",
    mode     => '0644',
    content  => template("controller_ocata/ssl.conf.erb"),
  }

  ### DB Creation if not exist and grant privileges.

  package { "mysql":
    ensure  => installed,
  }

  exec { "create-$aai_db_name-db":
      unless => "/usr/bin/mysql -u root ${aai_db_host}",
      command => "/usr/bin/mysql -uroot -e \"create database if not exits ${aai_db_name}; grant all on ${aai_db_name}.* to ${aai_db_user}@localhost identified by '${aai_db_pwd}'; grant all on ${aai_db_name}.* to ${aai_db_user}@'${vip_mgmt}' identified by '${aai_db_pwd}';\""
  }

  exec { "migrate_db":
      command => "runuser -s /bin/bash -c 'python /usr/share/openstack-dashboard/manage.py migrate' -- apache"
  }
}
