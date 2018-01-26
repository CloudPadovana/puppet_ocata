class controller_ocata::install_ca_cert inherits controller_ocata::params {

  yumrepo { "EGI-trustanchors":
          baseurl=> "http://repository.egi.eu/sw/production/cas/1/current/",
          descr=> "EGI Software Repository - REPO META (releaseId,repositoryId,repofileId) - (13352,-,2387)",
          enabled=> 1,
          gpgcheck=> 1,
          gpgkey=> 'http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3',
  }

  

  $capackages = [   "ca-policy-egi-core",
                         "fetch-crl"
                     ]
  package { $capackages: ensure => "installed" }

  package { "ca_TERENA-SSL-CA-3":
    source   => "http://igi-01.pd.infn.it/mrepo/CAP/misc/CentOS7/current/ca_TERENA-SSL-CA-3.el7.centos.noarch.rpm",
    provider => "rpm",
    require  => Package[$capackages],
  }

  file {'INFN-CA.pem':
    source  => 'puppet:///modules/controller_ocata/INFN-CA.pem',
    path    => '/etc/grid-security/certificates/INFN-CA.pem',
  }

  file { 'cert_pem':
    path    => '/etc/grid-security/cert.pem',
    source  => '/etc/grid-security/hostcert.pem',
    ensure  => 'present',
    owner   => 'apache',
    group   => 'apache',
  }

  file { 'key_pem':
    path    => '/etc/grid-security/key.pem',
    source  => '/etc/grid-security/hostkey.pem',
    ensure  => 'present',
    owner   => 'apache',
    group   => 'apache'
  }

}
