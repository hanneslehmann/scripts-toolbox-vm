#!/usr/bin/env bash
echo "Configuring apt-get for cached install..." >> /var/log/bootstrap.log
cp /etc/apt/sources.list /etc/apt/sources.list.backup.approx
echo "192.168.15.20      approx" |  tee -a  /etc/hosts 
sed -i 's/httpredir.debian.org/approx:9999/g' /etc/apt/sources.list
sed -i 's/security.debian.org/approx:9999/g' /etc/apt/sources.list
sed -i 's/http.debian.net/approx:9999/g' /etc/apt/sources.list
sed -i 's/ftp.uk.debian.org/approx:9999/g' /etc/apt/sources.list