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

  package { "openstack-auth-cap":
    ensure  => present,
    require => Exec["download_cap_repo"],
  }
  
  file { "/usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.d/_1002_aai_settings.py":
    ensure   => file,
    owner    => "root",
    group    => "apache",
    mode     => '0640',
    content  => template("controller_ocata/aai_settings.py.erb"),
  }
}
