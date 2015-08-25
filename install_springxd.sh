#!/usr/bin/env bash
echo "Starting install Spring XD..." >> /var/log/bootstrap.log

### Setup Spring XD
wget https://repo.spring.io/libs-release/org/springframework/xd/spring-xd/1.2.1.RELEASE/spring-xd-1.2.1.RELEASE-dist.zip -P /tmp
unzip /tmp/spring-xd-1.2.1.RELEASE-dist.zip -d /opt/
mv /opt/spring-xd-1.2.1.RELEASE/ /opt/spring-xd
echo "export XD_HOME=/opt/spring-xd/xd" >> /home/vagrant/.bashrc
mkdir -p /opt/spring-xd/xd/data/
chmod 777 /opt/spring-xd/xd/data
rm /tmp/spring-xd-1.2.1.RELEASE-dist.zip
