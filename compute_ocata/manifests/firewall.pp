class compute_ocata::firewall inherits compute_ocata::params {

#include compute_ocata::params

  service { "NetworkManager":
             ensure      => stopped,
             enable      => false,
          }
       
  
  service { "firewalld":
             ensure      => running,
             enable      => true,
          }

     # Puppet
  exec { "open-port-8139-tcp":
    command=> "/usr/bin/firewall-cmd --add-port=8139/tcp; /usr/bin/firewall-cmd --permanent --add-port=8139/tcp",
    unless=> "/usr/bin/firewall-cmd --query-port 8139/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

    # Puppet
  exec { "open-port-8139-udp":
    command=> "/usr/bin/firewall-cmd --add-port=8139/udp; /usr/bin/firewall-cmd --permanent --add-port=8139/udp",
    unless=> "/usr/bin/firewall-cmd --query-port 8139/udp | grep yes  | wc -l | xargs test 1 -eq",
       }

# OpenManage
  exec { "open-port-8649-tcp":
             command=> "/usr/bin/firewall-cmd --add-port=8649/tcp; /usr/bin/firewall-cmd --permanent --add-port=8649/tcp",
             unless=> "/usr/bin/firewall-cmd --query-port 8649/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }
# OpenManage
  exec { "open-port-1031-tcp":
             command=> "/usr/bin/firewall-cmd --add-port=1031/tcp; /usr/bin/firewall-cmd --permanent --add-port=1031/tcp",
             unless=> "/usr/bin/firewall-cmd --query-port 1031/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }
# OpenManage
  exec { "open-port-161-udp":
             command=> "/usr/bin/firewall-cmd --add-port=161/udp; /usr/bin/firewall-cmd --permanent --add-port=161/udp",
             unless=> "/usr/bin/firewall-cmd --query-port 161/udp | grep yes  | wc -l | xargs test 1 -eq",
       }
               
      
  exec { "open-port-22":
    command=> "/usr/bin/firewall-cmd --add-port=22/tcp; /usr/bin/firewall-cmd --permanent --add-port=22/tcp",
    unless=> "/usr/bin/firewall-cmd --query-port 22/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }
 
  exec { "open-port-5900-5999":
    command=> "/usr/bin/firewall-cmd --add-port=5900-5999/tcp; /usr/bin/firewall-cmd --permanent --add-port=5900-5999/tcp",
    unless=> "/usr/bin/firewall-cmd --query-port 5900-5999/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

  exec { "open-port-16509":
    command=> "/usr/bin/firewall-cmd --add-port=16509/tcp; /usr/bin/firewall-cmd --permanent --add-port=16509/tcp",
    unless=> "/usr/bin/firewall-cmd --query-port 16509/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

      
  exec { "open-port-49152-49261":
    command=> "/usr/bin/firewall-cmd --add-port=49152-49261/tcp; /usr/bin/firewall-cmd --permanent --add-port=49152-49261/tcp",
    unless=> "/usr/bin/firewall-cmd --query-port 49152-49261/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

  exec { "open-port-123":
    command=> "/usr/bin/firewall-cmd --add-port=123/udp; /usr/bin/firewall-cmd --permanent --add-port=16509/udp",
    unless=> "/usr/bin/firewall-cmd --query-port 123/udp | grep yes  | wc -l | xargs test 1 -eq",
       }

  exec { "open-gre":
    command=> "/usr/bin/firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT; /usr/bin/firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT",
    unless=> "/usr/bin/firewall-cmd --direct --get-all-rules | grep \"ipv4 filter INPUT 0 -p gre -j ACCEPT\"  | wc -l | xargs test 1 -eq",
       }

# Bacula
  exec { "open-9102":
    command=> "/usr/bin/firewall-cmd --zone=public --add-rich-rule='rule family=\"ipv4\" source address=\"192.84.143.133/32\" port protocol=\"tcp\" port=\"9102\" accept'; /usr/bin/firewall-cmd --permanent --zone=public --add-rich-rule='rule family=\"ipv4\" source address=\"192.84.143.133/32\" port protocol=\"tcp\" port=\"9102\" accept'",
    unless=> "/usr/bin/firewall-cmd --list-rich-rules | grep 9102| wc -l | xargs test 1 -eq",
}
       
}
