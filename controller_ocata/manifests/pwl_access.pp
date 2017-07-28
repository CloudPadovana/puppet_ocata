class controller_ocata::pwl_access {

#
# Questa classe configura ssh per l'account nova in modo da permettere accesso password-less
# tra i vari nodi dell'installazione
#
  
  $home_dir = "/var/lib/nova"
  $config = "Host *
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
"



  user {'nova':
        ensure	=> present,
        shell	=> '/bin/bash',
  }

  file {"nova_sshdir":
            ensure  => "directory",
            path    => "$home_dir/.ssh",
            owner   => nova,
            group   => nova,
            mode    => 0700,
  }

  File["nova_sshdir"] -> file {
	"config_ssh":
            path    => "$home_dir/.ssh/config",
	    content => "$config",
            owner   => nova,
            group   => nova;

	"private_key":
	    source  => "puppet:///modules/controller_ocata/$controller_ocata::params::private_key",
	    path    => "$home_dir/.ssh/id_rsa",
            owner   => nova,
            group   => nova,
            mode    => 0600;

	"public_key":
            path    => "$home_dir/.ssh/id_rsa.pub",
            content => "$controller_ocata::params::pub_key",
            owner   => nova,
            group   => nova;

        "authorized_keys":
            path    => "$home_dir/.ssh/authorized_keys",
            content => "$controller_ocata::params::pub_key",
            ensure  => present,
            owner   => nova,
            group   => nova;
        }
}
