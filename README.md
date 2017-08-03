# puppet_ocata
puppet classes for openstack ocata cloud (controller and compute configuration)

All the sensible data are removed.
Precisely all the passwords, hosts, ip addresses and keys are removed from /controller_ocata/manifests/params.pp, /compute_ocata/manifests/params.pp and also in files located in /controller_ocata/files and /compute_ocata/files.

The params.pp module has $cloud_role parameter to set. Regard to controller_ocata class we have 2 possible value for $cloud_role ("is_test" for test cloud and "is_production" for production cloud), regards to compute_ocata class we have 3 value ("is_test" for test cloud, "is_prod_localstorage" and "is_prod_sharedstorage" for production cloud). Depends on the needed, you can add different value and set the proper conditions in params.pp (and in the propers .pp files, in case paticular conditions occurs for the configuration of specific submodules), in this way you can manage all ocata deployments using the same module.
With Foreman you can set all this value for $cloud_role using matchers. To do so go to configure->classes and choose compute_ocata::params and/or controller_ocata::params, then in Smart Class Parameter menu' you can add a specific matcher; select the attribute type hostgroup, the name of the hostgroup and the value of cloud_role for that hostgroup and then submit. In this way you can set different parameters for different hostgroup once for all. 
In order to mantain the configuration of the cloud with foreman you have to add: controller_ocata and controller_ocata::params submodules (in this way you can set the cloud_role variable) for controller nodes, in the same way compute_ocata and compute_ocata::params for compute nodes.
