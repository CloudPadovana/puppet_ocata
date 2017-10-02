class controller_ocata::configure_horizon inherits controller_ocata::params {
  
  file { "/etc/httpd/conf.d/ssl.conf":
    ensure   => file,
    owner    => "root",
    group    => "root",
    mode     => '0644',
    content  => template("controller_ocata/ssl.conf.erb"),
  }
  
  file { "/etc/httpd/conf.d/openstack-dashboard.conf":
    ensure   => file,
    owner    => "root",
    group    => "root",
    mode     => '0644',
    content  => file("controller_ocata/openstack-dashboard.conf"),
  }
 
  file { "/etc/openstack-dashboard/local_settings":
    ensure   => file,
    owner    => "root",
    group    => "apache",
    mode     => '0640',
    content  => template("controller_ocata/local_settings.erb"),
  }

  ############################################################################
  #  OS-Federation
  ############################################################################
  if $enable_aai_ext {
 
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


  ### DB Creation if not exist and grant privileges.

    package { "mariadb":
      ensure  => installed,
    }

    exec { "create-$aai_db_name-db":
        command => "/usr/bin/mysql -u root -h ${aai_db_host} -e \"create database IF NOT EXISTS ${aai_db_name}; grant all on ${aai_db_name}.* to ${aai_db_user}@localhost identified by '${aai_db_pwd}'; grant all on ${aai_db_name}.* to ${aai_db_user}@'${vip_mgmt}' identified by '${aai_db_pwd}'; grant all on ${aai_db_name}.* to ${aai_db_user}@'${ip_ctrl1}' identified by '${aai_db_pwd}'; grant all on ${aai_db_name}.* to ${aai_db_user}@'${ip_ctrl2}' identified by '${aai_db_pwd}';\""
    }

    exec { "migrate_db":
        command => "/usr/sbin/runuser -s /bin/bash -c 'python /usr/share/openstack-dashboard/manage.py migrate' -- apache"
    }
  }
}
