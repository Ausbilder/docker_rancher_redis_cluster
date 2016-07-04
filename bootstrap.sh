#!/bin/bash

echo "Redis Config: "
cat /redis/redis.conf

echo "Given Variables: Redis Node Port: $REDIS_NODE_PORT, Replication Factor: $REDIS_REPLICATION"

########### INIT NODE ###########
if [ "$1" == "init" ]; then

	
	echo "Getting Container List for Service $service" #available in ENV VAR CONTAINER Key-Vale: Hostname - IP
	source /redis/getContainerListForService.sh redis
	
	for ip in ${CONTAINER[@]};
	do
	nodes_with_port+=" $ip:$REDIS_NODE_PORT"
	echo "Adding Container: $ip to Redis Cluster config"
	done
	
	echo "Starting Cluster with ./src/redis-trib.rb create --replicas $REDIS_REPLICATION $nodes_with_port"
	echo "yes" | /redis/src/redis-trib.rb create --replicas $REDIS_REPLICATION $nodes_with_port

	echo "Redis Cluster up and running - shutting down init Container ... bye"	

	
	########### REDIS NODE ###########
else
	echo "Starting Node with src/redis-server /redis/redis.conf --port $REDIS_NODE_PORT"
	supervisord -c /redis/supervisord_node.conf
fi
