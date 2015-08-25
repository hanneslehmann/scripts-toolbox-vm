#!/usr/bin/env bash
echo "Adding repos..." > /var/log/bootstrap.log
echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list