#!/usr/bin/env bash
echo "Starting MongoDB install..." >> /var/log/bootstrap.log
apt-get install -y  mongodb-server mongodb-clients 
service mongodb stop
echo "smallfiles=true" | tee -a /etc/mongodb.conf
rm -rf /var/lib/mongodb/journal/*
service mongodb start