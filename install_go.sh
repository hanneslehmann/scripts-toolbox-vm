#!/usr/bin/env bash
echo "Starting install and configure Go..." >> /var/log/bootstrap.log

#install gvm
sudo -H -u vagrant bash -c "bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)"
echo '[[ -s "\\$HOME/.gvm/scripts/gvm" ]] && source "\\$HOME/.gvm/scripts/gvm"' >> /home/vagrant/.profile

#install go
sudo -H -u vagrant bash -c "source /home/vagrant/.gvm/scripts/gvm && gvm install go1.4"
sudo -H -u vagrant bash -c "source /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && go get launchpad.net/gorun"
	 
#install gpm
wget https://raw.githubusercontent.com/pote/gpm/v1.3.2/bin/gpm && chmod +x gpm && mv gpm /usr/local/bin	 

	 #sudo -H -u vagrant bash -c "source /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && go get github.com/garyburd/redigo/redis"
	 #sudo -H -u vagrant bash -c "source /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && go get github.com/vaughan0/go-ini"
	 
	 
#  wget https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.3.5.linux-amd64.go1.4.2.tar.gz -P /tmp

# install some other tools..
# go get github.com/jehiah/json2csv
