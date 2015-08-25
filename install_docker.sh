#!/usr/bin/env bash
echo "Starting docker install..." >> /var/log/bootstrap.log
apt-get -y install docker.io
groupadd docker
gpasswd -a vagrant docker
service docker restart