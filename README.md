# puppet_ocata

#### Table of Contents

1. [Overview](#overview)
2. [Document Openstack Ocata](#document-openstack-ocata)
3. [Requirements](#Requirements)
4. [Tested on](#tested-on)
5. [Usage with foreman](#usage-with-foreman)
    * [Donwload the module from git](#donwload-the-module-from-git)
    * [Import the module in foreman](#import-the-module-in-foreman)
    * [Configure the module with your parameters](#configure-the-module)
       * [FOR OUR SPECIFIC USE](#specific-use)
    * [Assign the module to host in foreman](#assign-module-foreman-host)

## Overview

With this module two puppet classes will be deployed: 
* openstack ocata controller 
* openstack ocata compute

The controller class configure an openstack ocata controller with all the params set in params.pp. This particular module could configure a HA configuration with 2 controller nodes under HAProxy and Keepalived processes with a VIP. The module accept a initial parameter the cloud_role or cloud_role_foreman. Regard to controller_ocata class we have 2 possible value for $cloud_role ("is_test" for test cloud and "is_production" for production cloud), regards to compute_ocata class we have 3 value for cloud_role_foreman ("is_test" for test cloud, "is_prod_localstorage" and "is_prod_sharedstorage" for production cloud). This could be "is_test", "is_prod_localstorage" and "is_prod_sharedstorage". This module do not update rpms but just configure all openstack services (keystone, nova, neutron, horizon, glance, cinder, ceilometer, heat, ec2). This module also configure an ad hoc customization for dashboard if the param  $enable_aai_ext is set to true allow to configure shibboleth or openidc for authenticate users in openstack this differente tecnology like SAML2 or OpenIdc. For this part also some rpms will be installed.

The compute class makes a total upgrade from mitaka release to ocata release of one compute node. Change the repo file and install all rpms needed by ocata release and ceph jewel. Configure the compute node with all params set in params.pp

## Document Openstack Ocata
* [Documentation](https://releases.openstack.org/ocata/)
* [Documentation Install and Configuration in CentOS7](https://docs.openstack.org/ocata/install-guide-rdo/)

## Requirements

The module require a CentOS7 Operationg system to work and an openstack Mitaka previously installed in the host. For the controller class also the rpms upgrade must be done before running it in the host with puppet.
 
## Tested on

Tested on a cluster of 7 hosts with CentOS7 installed (2 Openstack Controllers, 3 Openstack Compute, 1 HAProxy with keepalived, 1 mysql host)

## Usage with foreman

### Download the module from git 
Change directory in path external of the puppet module path for example in /opt or /var and clone the repo and create a symbolic link to puppt module path:

    $ git clone https://github.com/CloudPadovana/puppet_ocata.git
    $ cd puppet_ocata
    $ ln -s controller_ocata /etc/puppet/environments/production/modules
    $ ln -s compute_ocata /etc/puppet/environments/production/modules

### Import the module in foreman

Inside foreman web application go to Configure -> Puppet classes
Push the import button. (Import from <puppetmester host>
Check the Add tips to controller_ocata and compute_ocata line and click Import.

### Configure the module with your parameters:

All the sensible data are removed.
Precisely all the passwords, hosts, ip addresses and keys are removed from /controller_ocata/manifests/params.pp, /compute_ocata/manifests/params.pp and also in files located in /controller_ocata/files and /compute_ocata/files.
So you have to copy the params.pp.template to parmas.pp and set all the data you need fpr yous configuraion.

#### FOR OUR SPECIFIC USE: the configuration has been present in our puppet master. The file params.pp in /var/puppet_ocata/controller_ocata/manifests/params.pp and /var/puppet_ocata/compute_ocata/manifests/params.pp has been set with all we need for production and test infrastructure.

### Assign the module to host in foreman

For all compute nodes edit the host and go in Puppet Class TAB assign just compute_ocata click on + near the compute_ocata module. Go in Parameters TAB and Override the parameter cloud_role_foreman with "is_test", "is_prod_localstorage" or "is_prod_sharedstorage" value.

If an hostgorup will be cdreate from foreman you could from main screen go to Configure -> Classes find compute_ocata and click to edi the class. Go in Smart Class Paramter TAB and in the bottom Part you can specify the Matcher with a matcher for a specific hostgorup or a specific host using FQDN, just for the parameter cloud_role_foreman

For controller nodes edit the host and go in Puppet Class TAB assign controller_ocata and controller_ocata::params click on +. For the controller_ocata::params class set properly the cloud_role with "is_test" or "is_production". You can do the same as compute node or editing the host or editing the class (controller_ocata::params)
