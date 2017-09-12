#!/bin/sh 
#Nagios server                                                                                                               
nagios_server=""
#
# Nagios client confifuration file                                                                                            
nagios_conf="/etc/nagios/send_nsca.cfg"
#
hostname=`/bin/hostname -s`
#                                                                                                                             
kvm_status=`/usr/local/bin/check_kvm`
kvm_status_retcode=$?
echo -e "$hostname\tKVM\t${kvm_status_retcode}\t${kvm_status}\n" | /usr/sbin/send_nsca -H ${nagios_server} -c ${nagios_conf}

