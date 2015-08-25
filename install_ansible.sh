#!/usr/bin/env bash
echo "Starting ansible install..." >> /var/log/bootstrap.log
apt-get update
apt-get install python-pip python-dev git -y
pip install PyYAML jinja2 paramiko
cd /tmp && git clone https://github.com/ansible/ansible.git
cd /tmp/ansible && make install
mkdir /etc/ansible
cp /tmp/ansible/examples/hosts /etc/ansible/
mv  /tmp/ansible /opt/