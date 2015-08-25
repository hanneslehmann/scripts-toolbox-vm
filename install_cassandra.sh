#!/usr/bin/env bash
echo "Starting install and configure Cassandra..." >> /var/log/bootstrap.log
	 ## Install Cassandra
	 apt-get install libjna-java -y
	 # add the DataStax Community repository
	 echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list 
	 # add the DataStax repository key to your aptitude trusted keys
	 curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add - 
	 apt-get update
	 sudo apt-get install dsc21 -y
	 service cassandra stop
	 sed -i 's/# JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=<public name>"/JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=localhost"/g'  /etc/cassandra/cassandra-env.sh
	 sed -i 's/#MAX_HEAP_SIZE="4G"/MAX_HEAP_SIZE="500M"/g'  /etc/cassandra/cassandra-env.sh
	 sed -i 's/#HEAP_NEWSIZE="800M"/HEAP_NEWSIZE="200M"/g'  /etc/cassandra/cassandra-env.sh
	 rm -rf /run/cassandra/
	 service cassandra start
	 # Create Demo DB
	 echo "CREATE KEYSPACE demo WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 }; use demo; CREATE TABLE writer (first_name text,last_name text,age int,PRIMARY KEY (last_name));" | cqlsh -u cassandra -p cassandra
	 # check status: nodetool status
	 # login: cqlsh -u cassandra -p cassandra