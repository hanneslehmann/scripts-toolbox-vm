#!/usr/bin/env bash
echo "Starting install and configure NodeJS..." >> /var/log/bootstrap.log
   	 ### Install NodeJS
	 cd  /home/vagrant/ && curl -sL https://deb.nodesource.com/setup |  bash -
	 apt-get install -y nodejs
	 apt-get install -y npm
	 npm config set registry http://registry.npmjs.org/
	 sudo ln -s /usr/bin/nodejs /usr/bin/node
	 
	 # Install addionitional NodeJS modules
	 npm install -g node-red
	 npm install -g mongodb
	 npm install -g node-red-node-redis  
	 npm install -g node-mysql mysql
	 npm install -g sqlite3
	 npm install -g redis-commander