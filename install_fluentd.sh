#!/usr/bin/env bash
echo "Starting Fluentd and Kibana install..." >> /var/log/bootstrap.log
	 #fluentd
	 echo "root soft nofile 65536" >> /etc/security/limits.conf
	 echo "root hard nofile 65536" >> /etc/security/limits.conf
	 echo "* soft nofile 65536" >> /etc/security/limits.conf
	 echo "* hard nofile 65536" >> /etc/security/limits.conf
	 # curl -L https://td-toolbelt.herokuapp.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
	 cd /tmp &&  wget http://packages.treasuredata.com/2/ubuntu/lucid/pool/contrib/t/td-agent/td-agent_2.2.0-0_amd64.deb
	 cd /tmp && dpkg -i td-agent_2.2.0-0_amd64.deb
	 /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-elasticsearch
	 /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-record-reformer
	 sed -i 's/port 8888/port 9999/g' /etc/td-agent/td-agent.conf
	 # let's log nginx
	 usermod -a -G adm td-agent
	 usermod -a -G www-data td-agent
	 echo "<source>" >>  /etc/td-agent/td-agent.conf
	 echo "type tail" >>  /etc/td-agent/td-agent.conf
	 echo "path /var/log/nginx/access.log #...or where you placed your Apache access log" >>  /etc/td-agent/td-agent.conf
	 echo "pos_file /var/log/td-agent/httpd-access.log.pos # This is where you record file position" >>  /etc/td-agent/td-agent.conf
	 echo "tag nginx.access #fluentd tag!" >>  /etc/td-agent/td-agent.conf
	 echo "format nginx # Do you have a custom format? You can write your own regex." >>  /etc/td-agent/td-agent.conf
	 echo "</source>" >>  /etc/td-agent/td-agent.conf
	 echo "<source>" >>  /etc/td-agent/td-agent.conf
	 echo "type tail" >>  /etc/td-agent/td-agent.conf
	 echo "path /var/log/nginx/gitlab_error.log #...or where you placed your Apache access log" >>  /etc/td-agent/td-agent.conf
	 echo "pos_file /var/log/td-agent/git-error.log.pos # This is where you record file position" >>  /etc/td-agent/td-agent.conf
	 echo "tag nginx.access #fluentd tag!" >>  /etc/td-agent/td-agent.conf
	 echo "format nginx # Do you have a custom format? You can write your own regex." >>  /etc/td-agent/td-agent.conf
	 echo "</source>" >>  /etc/td-agent/td-agent.conf
	 echo "<source>" >>  /etc/td-agent/td-agent.conf
	 echo "type tail" >>  /etc/td-agent/td-agent.conf
	 echo "path /var/log/nginx/gitlab_access.log #...or where you placed your Apache access log" >>  /etc/td-agent/td-agent.conf
	 echo "pos_file /var/log/td-agent/git-access.log.pos # This is where you record file position" >>  /etc/td-agent/td-agent.conf
	 echo "tag nginx.access #fluentd tag!" >>  /etc/td-agent/td-agent.conf
	 echo "format nginx # Do you have a custom format? You can write your own regex." >>  /etc/td-agent/td-agent.conf
	 echo "</source>" >>  /etc/td-agent/td-agent.conf	 
	 echo "<match **> " >>  /etc/td-agent/td-agent.conf
	 echo "type elasticsearch" >>  /etc/td-agent/td-agent.conf
	 echo "logstash_format true" >>  /etc/td-agent/td-agent.conf
	 echo "host localhost #(optional; )" >>  /etc/td-agent/td-agent.conf
	 echo "port 9200 #(optional; default=9200)" >>  /etc/td-agent/td-agent.conf
	 echo "index_name fluentd #(optional; default=fluentd)" >>  /etc/td-agent/td-agent.conf
	 echo "type_name fluentd #(optional; default=fluentd)" >>  /etc/td-agent/td-agent.conf
	 echo "</match>" >>  /etc/td-agent/td-agent.conf
	 /etc/init.d/td-agent restart
	 # test:  curl -X POST -d 'json={"json":"message"}' http://localhost:9999/debug.test
	 # elastic search
	 cd /tmp &&  wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.6.0.deb
	 cd /tmp &&  dpkg -i elasticsearch-1.6.0.deb
	 # test with: curl -X GET http://localhost:9200/
	 # kibana
	 cd /tmp && curl -L https://download.elastic.co/kibana/kibana/kibana-4.1.0-linux-x64.tar.gz | tar xzf -
	 cp -r /tmp/kibana-4.1.0-linux-x64 /opt
	 mv /opt/kibana-4.1.0-linux-x64 /opt/kibana
	 service elasticsearch start
	 # test: curl 'localhost:9200/_cat/indices?v'
	 sudo -H -u vagrant bash -c "nohup  /opt/kibana/bin/kibana >> /home/vagrant/kibana.log 2>&1"
	 /etc/init.d/td-agent restart
	 
	 cd /tmp && rm *.deb
	 cd /tmp && rm *.tar.gz