#!/usr/bin/env bash
echo "Cleaning up..." >> /var/log/bootstrap.log
apt-get update
apt-get upgrade -y

apt-get clean

