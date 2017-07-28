class compute_ocata::firewall {

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
    command=> "firewall-cmd --add-port=8139/tcp; firewall-cmd --permanent --add-port=8139/tcp",
    unless=> "firewall-cmd --query-port 8139/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

    # Puppet
  exec { "open-port-8139-udp":
    command=> "firewall-cmd --add-port=8139/udp; firewall-cmd --permanent --add-port=8139/udp",
    unless=> "firewall-cmd --query-port 8139/udp | grep yes  | wc -l | xargs test 1 -eq",
       }

# OpenManage
  exec { "open-port-8649-tcp":
             command=> "firewall-cmd --add-port=8649/tcp; firewall-cmd --permanent --add-port=8649/tcp",
             unless=> "firewall-cmd --query-port 8649/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }
# OpenManage
  exec { "open-port-1031-tcp":
             command=> "firewall-cmd --add-port=1031/tcp; firewall-cmd --permanent --add-port=1031/tcp",
             unless=> "firewall-cmd --query-port 1031/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }
# OpenManage
  exec { "open-port-161-udp":
             command=> "firewall-cmd --add-port=161/udp; firewall-cmd --permanent --add-port=161/udp",
             unless=> "firewall-cmd --query-port 161/udp | grep yes  | wc -l | xargs test 1 -eq",
       }
               
      
  exec { "open-port-22":
    command=> "firewall-cmd --add-port=22/tcp; firewall-cmd --permanent --add-port=22/tcp",
    unless=> "firewall-cmd --query-port 22/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }
 
  exec { "open-port-5900-5999":
    command=> "firewall-cmd --add-port=5900-5999/tcp; firewall-cmd --permanent --add-port=5900-5999/tcp",
    unless=> "firewall-cmd --query-port 5900-5999/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

  exec { "open-port-16509":
    command=> "firewall-cmd --add-port=16509/tcp; firewall-cmd --permanent --add-port=16509/tcp",
    unless=> "firewall-cmd --query-port 16509/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

      
  exec { "open-port-49152-49261":
    command=> "firewall-cmd --add-port=49152-49261/tcp; firewall-cmd --permanent --add-port=49152-49261/tcp",
    unless=> "firewall-cmd --query-port 49152-49261/tcp | grep yes  | wc -l | xargs test 1 -eq",
       }

  exec { "open-port-123":
    command=> "firewall-cmd --add-port=123/udp; firewall-cmd --permanent --add-port=16509/udp",
    unless=> "firewall-cmd --query-port 123/udp | grep yes  | wc -l | xargs test 1 -eq",
       }

  exec { "open-gre":
    command=> "firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT",
    unless=> "firewall-cmd --direct --get-all-rules | grep \"ipv4 filter INPUT 0 -p gre -j ACCEPT\"  | wc -l | xargs test 1 -eq",
       }

}
