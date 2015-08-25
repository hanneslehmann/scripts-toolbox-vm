#!/usr/bin/env bash
echo "Starting install and configure etcd..." >> /var/log/bootstrap.log
## Install etcd
#sudo -H -u vagrant bash -c ". /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && go get github.com/coreos/go-etcd/etcd"
#sudo -H -u vagrant bash -c ". /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && nohup etcd & >> /home/vagrant/etcd.log"
cd /tmp && curl -L  https://github.com/coreos/etcd/releases/download/v2.0.13/etcd-v2.0.13-linux-amd64.tar.gz -o etcd-v2.0.13-linux-amd64.tar.gz
cd /tmp && tar xzvf etcd-v2.0.13-linux-amd64.tar.gz
cp /tmp/etcd-v2.0.13-linux-amd64/etcd* /usr/bin
sudo -H -u vagrant bash -c ". /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && nohup etcd & >> /home/vagrant/etcd.log"