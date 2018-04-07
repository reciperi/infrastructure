# node default {

#   include 'monitoring_script'
#   include 'factorial_backend'
#   include 'factorial_frontend'

#   include 'factorial_wordpress'
#   include 'factorial_dispatcher'
#   include 'factorial_infrastructure'

#   include 'redis_master_server'
#   include 'memcached_server'

#   include 'munin_node_agent'
#   include 'graphite_web_node'
#   include 'munin2graphite_agent'

#   include 'elasticsearch_node'
#   include 'kibana_node'
#   include 'logstash_node'

#   include rabbitmq_node
#   include redis_sentinel_agent
#   include sensu_server_node
#   include sensu_client_agent
#   include uchiwa_node

#   include 'mysql_server'


#   file { '/etc/rc.local':
#     owner   => 'root',
#     group   => 'root',
#     mode    => '0755',
#     content => '
#     iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#     iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
#     iptables -A INPUT -i eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
#     iptables -I INPUT   -m state --state ESTABLISHED,RELATED -j ACCEPT
#     iptables -I INPUT  -i lo -j ACCEPT
#     iptables -P INPUT DROP

#     #SWAP The fcsonline way
#     fallocate -l 2G /swapfile
#     chmod 600 /swapfile
#     mkswap /swapfile
#     swapon /swapfile

#     exit 0
#     ',
#   } ~> exec { '/etc/rc.local':
#     refreshonly => true,
#   }

# }
