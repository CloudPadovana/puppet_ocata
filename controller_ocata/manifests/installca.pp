class controller_ocata::installca {

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


}
