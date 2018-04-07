# # The old server
# node default {

#   $subenvironment = ''

#   include 'monitoring_script'
#   include 'factorial_backend'
#   include 'factorial_frontend'

#   include 'factorial_wordpress'
#   include 'factorial_dispatcher'
#   include 'factorial_infrastructure'

#   include 'redis_master_server'
#   include 'memcached_server'

# }

# node /^ops/ {
#   $subenvironment = ''
#   include factorial_dispatcher
#   include factorial_infrastructure
#   include bastion_sshd

#   include sensu_server_node
#   include sensu_client_agent
#   include rabbitmq_node
#   include uchiwa_node
#   include server

#   include kibana_node
#   include logstash_node

#   include graphite_web_node

#   if ($hostname == 'ops01') {
#     include munin2graphite_agent
#     include chartio_tunnel_service
#   } else {
#     include redis_sentinel_agent
#   }
#   include munin_node_agent

# }

# node /^app/ {
#   $subenvironment = ''
#   include factorial_backend
#   include factorial_frontend
#   include factorial_infrastructure
#   include factorial_wordpress

#   if ($hostname == 'app01') {
#     include redis_master_server
#   }
#   if ($hostname == 'app02') {
#     include redis_slave_server
#   }
#   include memcached_server
#   include elasticsearch_node
#   include redis_sentinel_agent
#   include sensu_client_agent
#   include server
#   include munin_node_agent
# }
