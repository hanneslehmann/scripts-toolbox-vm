#!/usr/bin/env bash

	 apt-get update
	 echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
     echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
     apt-get install -y git ant nano curl ca-certificates postfix mercurial make binutils bison gcc build-essential g++ cmake nginx
     #echo "deb http://cran.rstudio.com/bin/linux/ubuntu precise/" |  tee /etc/apt/sources.list.d/r-cran.list
	 add-apt-repository ppa:marutter/rrutter -y
	 #apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
	 #apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 # mongodb
	 #echo "deb http://repo.mongodb.org/apt/ubuntu $(lsb_release -sc)/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
     sudo apt-get update
	 apt-get install -f
	 sudo apt-get install -y pandoc mosquitto mosquitto-clients mysql-server mysql-client libmysqlclient-dev rabbitmq-server graphviz bzr expect libxext-dev libfreetype6-dev  
	 apt-get install -y  lua5.2 liblua5.2-dev luarocks
	 apt-get install -y  python-software-properties python-zmq python-dev python-matplotlib python2.7-dev   python-pip python3-pip  python-qt4 qt4-dev-tools
	 apt-get install -y libzmq3-dev
     apt-get install -y  mongodb-server mongodb-clients 
	 apt-get install -y  r-base ghc r-cran-gplots haskell-platform opam 
	 # ipython3 ipython3-notebook
	 
	 ## Create needed accounts
	 adduser --disabled-login --gecos 'GitLab' git
	 
	 pip install virtualenv
	 pip install virtualenvwrapper
	 #BASE_DIR='/opt/workon' && mkdir $BASE_DIR && chmod a+w $BASE_DIR && export WORKON_HOME=$BASE_DIR/Envs  && chmod a+w $BASE_DIR/Envs && echo "export WORKON_HOME=$BASE_DIR/Envs" >> /etc/bash.bashrc
	 #source /usr/local/bin/virtualenvwrapper.sh && echo "source /usr/local/bin/virtualenvwrapper.sh" >> /etc/bash.bashrc
	 #BASE_DIR='/opt/workon' && export WORKON_HOME=$BASE_DIR/Envs && echo "export PIP_VIRTUALENV_BASE=$WORKON_HOME" >> /etc/bash.bashrc "
	 # cd /tmp && wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.2/PyQt-x11-gpl-4.11.2.tar.gz
	 cd /tmp && wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz 
	 cd /tmp && wget http://sourceforge.net/projects/pyqt/files/sip/sip-4.16.4/sip-4.16.4.tar.gz
	 cd /tmp && tar -zxvf PyQt-x11-gpl-4.11.4.tar.gz
	 cd /tmp && tar -zxvf sip-4.16.4.tar.gz
	 cd /tmp/sip-4.16.4/ && python configure.py && make && make install
	 cd /tmp/sip-4.16.4/ && python3 configure.py && make && make install
     ##Remove need for user input in the middle of the script - TODO: move this to start of script.
	 sed -i 's/resp = sys.stdin.readline()/resp = "yes"/g' /tmp/PyQt-x11-gpl-4.11.4/configure-ng.py
	 cd /tmp/PyQt-x11-gpl-4.11.4/ && python configure-ng.py && make && make install
	 cd /tmp/PyQt-x11-gpl-4.11.4/ && python3 configure-ng.py && make && make install
	
   	 ### Install NodeJS
	 cd  /home/vagrant/ && curl -sL https://deb.nodesource.com/setup |  bash -
	 apt-get install -y nodejs
	 apt-get install -y npm
	 npm config set registry http://registry.npmjs.org/
	 sudo ln -s /usr/bin/nodejs /usr/bin/node
	 
	 ### Install iPython and prerequisites
	 pip install markupsafe certifi pyzmq jinja2 tornado jsonschema functools32 numpy  pysimplesoap ipython-sql nxpd redis pymongo mpld3 mysql-python python-etcd elasticsearch  petl cassandra-driver blist --upgrade
	 pip install git+https://github.com/vispy/vispy.git
	 pip3 install redis pymongo mpld3 pyzmq  nxpd numpy  pysimplesoap ipython-sql python-etcd mysqlclient cassandra-driver blist
	 pip3 install git+https://github.com/vispy/vispy.git
	 pip install "ipython[all]"
	 pip3 install "ipython[all]"
	 
	 cd ~
	 wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
     python ez_setup.py
     python3 ez_setup.py
	 easy_install -U distribute
	  
	 ### Install NodeJS-Kernel
	 mkdir -p /home/vagrant/kernel_node 
	 cd  /home/vagrant/kernel_node	 
	 wget https://github.com/notablemind/jupyter-nodejs/releases/download/v1.1.0/jupyter-nodejs-1.1.0.tgz
	 cd /home/vagrant/kernel_node && tar xf jupyter-nodejs-1.1.0.tgz
	 mkdir -p /home/vagrant/.ipython/kernels/nodejs
	 chown -R vagrant:vagrant /home/vagrant/
	 
	 ### Setup R
	 sudo -H -u vagrant bash -c "mkdir -p ~/.R/libs/"
	 sudo -H -u vagrant bash -c "echo 'R_LIBS=~/.R/libs/' > /home/vagrant/.Renviron"
	 echo 'options(repos=structure(c(CRAN="http://cran.rstudio.com")))' | tee /home/vagrant/.Rprofile
	 chown vagrant:vagrant /home/vagrant/.Rprofile
	 echo "install.packages(c('codetools', 'rzmq' ,'base64enc', 'evaluate', 'jsonlite', 'uuid', 'digest','ggplot2'))" > /home/vagrant/r_install.script
	 echo "install.packages(c('repr','IRkernel','IRdisplay'), repos='http://irkernel.github.io/')" >> /home/vagrant/r_install.script
	 echo "install.packages(c('RMySQL','DBI','rmongodb','ngramr', 'ggplot2'))" >> /home/vagrant/r_install.script
	 chown vagrant:vagrant /home/vagrant/r_install.script
	 
	 ### Install IHaskell
	 #cd /home/vagrant/ && git clone http://www.github.com/gibiansky/IHaskell --depth=1
	 #cabal update
	 #cabal install cabal cabal-install 
	 #cd /home/vagrant/IHaskell/ && ./ubuntu_install.sh all # Build and install IHaskell
	 
	 ## Install go
	 #cd /tmp && wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
	 #cd /tmp && tar -C /usr/share -xzf /tmp/go1.4.2.linux-amd64.tar.gz
	 sudo -H -u vagrant bash -c "bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)"
	 echo '[[ -s "\\$HOME/.gvm/scripts/gvm" ]] && source "\\$HOME/.gvm/scripts/gvm"' >> /home/vagrant/.profile
	 sudo -H -u vagrant bash -c "source /home/vagrant/.gvm/scripts/gvm && gvm install go1.4 && gvm use go1.4 && go get launchpad.net/gorun"
	 
	 ## Install Go-Kernel
	 #sudo -H -u vagrant bash -c "echo 'export GOPATH=\\\$HOME/go' >> ~/.profile"
	 #sudo -H -u vagrant bash -c "echo 'export GOROOT=/usr/share/go' >> ~/.profile"
     #su vagrant -c "echo 'export PATH=\$PATH:\\\$GOPATH/bin' >> ~/.profile"
	 #sudo -H -u vagrant bash -c 'mkdir /home/vagrant/go'
	 sudo -H -u vagrant bash -c "mkdir -p /home/vagrant/.ipython/kernels/igo"
	 sudo -H -u vagrant bash -c 'cd /home/vagrant/ && source .profile && go get -tags zmq_3_x github.com/takluyver/igo'
	 sudo -H -u vagrant bash -c 'cd /home/vagrant/ && source .profile && cp -r /home/vagrant/go/src/github.com/takluyver/igo/kernel/* /home/vagrant/.ipython/kernels/igo'
	 sed -i 's/\$GOPATH/\/home\/vagrant\/go/g' /home/vagrant/.ipython/kernels/igo/kernel.json
	 
	 ## Install LUA Kernel
	 sudo -H -u vagrant bash -c "git clone https://github.com/facebook/iTorch.git --depth=1"
     sudo -H -u vagrant bash -c "cd /home/vagrant/iTorch && luarocks make --local"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/iTorch && luarocks install image --local"
	 sudo -H -u vagrant bash -c "mkdir -p /home/vagrant/.ipython/kernels/itorch"
	 sudo -H -u vagrant bash -c "cp /home/vagrant/iTorch/kernelspec/*.* /home/vagrant/.ipython/kernels/itorch"
	 sed -i 's/LUA_BINDIR/\/home\/vagrant\/iTorch/g' /home/vagrant/.ipython/kernels/itorch/kernel.json
	 chown -R vagrant:vagrant /home/vagrant/

	 # Install addionitional NodeJS modules
	 npm install -g node-red
	 npm install -g mongodb
	 npm install -g node-red-node-redis  
	 npm install -g node-mysql mysql
	 npm install -g sqlite3
	 
	 ## Install etcd
	 #sudo -H -u vagrant bash -c ". /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && go get github.com/coreos/go-etcd/etcd"
	 #sudo -H -u vagrant bash -c ". /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && nohup etcd & >> /home/vagrant/etcd.log"
	 cd /tmp && curl -L  https://github.com/coreos/etcd/releases/download/v2.0.13/etcd-v2.0.13-linux-amd64.tar.gz -o etcd-v2.0.13-linux-amd64.tar.gz
	 cd /tmp && tar xzvf etcd-v2.0.13-linux-amd64.tar.gz
	 cp /tmp/etcd-v2.0.13-linux-amd64/etcd* /usr/bin
	 sudo -H -u vagrant bash -c ". /home/vagrant/.gvm/scripts/gvm && gvm use go1.4 && nohup etcd & >> /home/vagrant/etcd.log"
	 
	 ## Install Cassandra
	 apt-get install libjna-java -y
	 # add the DataStax Community repository
	 echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list 
	 # add the DataStax repository key to your aptitude trusted keys
	 curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add - 
	 apt-get update
	 sudo apt-get install dsc21 -y
	 service cassandra stop
	 sed -i 's/# JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=<public name>"/JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=localhost"/g'  /etc/cassandra/cassandra-env.sh
	 sed -i 's/#MAX_HEAP_SIZE="4G"/MAX_HEAP_SIZE="500M"/g'  /etc/cassandra/cassandra-env.sh
	 sed -i 's/#HEAP_NEWSIZE="800M"/HEAP_NEWSIZE="200M"/g'  /etc/cassandra/cassandra-env.sh
	 rm -rf /run/cassandra/
	 service cassandra start
	 # Create Demo DB
	 echo "CREATE KEYSPACE demo WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 }; use demo; CREATE TABLE writer (first_name text,last_name text,age int,PRIMARY KEY (last_name));" | cqlsh -u cassandra -p cassandra
	 # check status: nodetool status
	 # login: cqlsh -u cassandra -p cassandra
	 
	 ## install ocaml
	 #cd /home/vagrant
	 #opam init -a
	 #opam update
	 #opam install iocaml -y
	 
	 ## setup MySQL for GitLab and access from external (e.g. Workbench)
	 # create script
	 echo "CREATE USER 'gitlab'@'localhost' IDENTIFIED BY 'gitlab';" > /home/vagrant/git_setup.sql
	 echo "CREATE DATABASE IF NOT EXISTS \\\`gitlabhq_production\\\` DEFAULT CHARACTER SET \\\`utf8\\\` COLLATE \\\`utf8_unicode_ci\\\`;" >> /home/vagrant/git_setup.sql
	 echo "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON \\\`gitlabhq_production\\\`.* TO 'gitlab'@'localhost';" >> /home/vagrant/git_setup.sql
	 echo "CREATE USER 'tester'@'localhost' IDENTIFIED BY 'test';" >> /home/vagrant/git_setup.sql
	 echo "CREATE DATABASE IF NOT EXISTS \\\`test_db\\\` DEFAULT CHARACTER SET \\\`utf8\\\` COLLATE \\\`utf8_unicode_ci\\\`;" >> /home/vagrant/git_setup.sql
	 echo "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, DROP, CREATE, DROP, INDEX, ALTER ON \\\`test_db\\\`.* TO 'tester'@'%';" >> /home/vagrant/git_setup.sql
	 echo "CREATE TABLE \\\`test_db\\\`.\\\`test\\\` (\\\`test\\\` int(11) NOT NULL, PRIMARY KEY (\\\`test\\\`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;" >> /home/vagrant/git_setup.sql
	 echo "Insert into \\\`test_db\\\`.test VALUES(1)" >> /home/vagrant/git_setup.sql
	 chown vagrant:vagrant /home/vagrant/git_setup.sql
	 # Create credentials file, might be deleted afterwards!
	 echo "[client]" > /home/vagrant/.my.cnf
	 echo "user = root"  >> /home/vagrant/.my.cnf
	 echo "password = root"  >> /home/vagrant/.my.cnf
	 cp /home/vagrant/.my.cnf /root
	 chown vagrant:vagrant /home/vagrant/.my.cnf
	 # run sql script for GitLab setup
	 sudo -H -u vagrant bash -c "cat /home/vagrant/git_setup.sql | mysql"
	 # make some tweaks to grant access from outside of the box
	 sed -i 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/my.cnf ## for access from outside
	 sed -i 's/bind-address/#bind-address/g' /etc/mysql/my.cnf ## for access from outside
     echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" | mysql   ## for access from outside
	 # flush and restart to apply changes
	 sudo -H -u vagrant bash -c "echo 'FLUSH PRIVILEGES;' | mysql" 
	 /etc/init.d/mysql restart
	 
	 ## Install ruby
	 apt-get remove ruby
	 apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev curl git-core openssh-server redis-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev camlp4-extra m4 zlib1g-dev tk-dev python3-tk jq
	 # configure redis
	 sed -i 's/# unixsocket/unixsocket/g'  /etc/redis/redis.conf
	 sed -i 's/# unixsocketperm 755/unixsocketperm 766/g'  /etc/redis/redis.conf
	 echo "unixsocketperm 766" >>  /etc/redis/redis.conf
	 /etc/init.d/redis-server restart

	 mkdir -p /tmp/ruby && cd /tmp/ruby && curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz | sudo tar xz
	 cd /tmp/ruby/ruby-2.1.5 && ./configure --disable-install-rdoc
	 cd /tmp/ruby/ruby-2.1.5 && make
	 cd /tmp/ruby/ruby-2.1.5 && sudo make install
	 gem install bundler --no-ri --no-rdoc
	 
	 ## Installation GitLab Shell
	 #sudo -u git -H bash -c "cd /home/git/gitlab && bundle exec rake gitlab:shell:install[v2.6.3] REDIS_URL=unix:/var/run/redis/redis.sock RAILS_ENV=production"
	 cd /home/git && sudo -u git -H git clone https://github.com/gitlabhq/gitlab-shell.git --depth=1
	 cd /home/git/gitlab-shell && sudo -u git -H git checkout v2.6.3
	 sudo -u git -H bash -c "cp /home/git/gitlab-shell/config.yml.example /home/git/gitlab-shell/config.yml"
	 cd /home/git/gitlab-shell/bin/ && sudo -u git ./install
	 # sudo -H -u vagrant expect -c 'cd "/home/git/gitlab" && bundle exec rake gitlab:setup RAILS_ENV=production; expect \\"Do you want to continue (yes/no)?\\"; send \\"yes\\";'
	 
	 ## Installation of Gitlab
	 
	 cd /home/git && sudo -u git -H git clone https://github.com/gitlabhq/gitlabhq.git gitlab
	 cd /home/git/gitlab && sudo -u git -H git checkout v7.12.0
	 sudo -u git -H cp /home/git/gitlab/config/gitlab.yml.example /home/git/gitlab/config/gitlab.yml
	 sudo -u git -H cp /home/git/gitlab/config/unicorn.rb.example /home/git/gitlab/config/unicorn.rb
	 sudo -u git -H cp /home/git/gitlab/config/database.yml.mysql /home/git/gitlab/config/database.yml
	 sudo -u git -H cp /home/git/gitlab/config/resque.yml.example /home/git/gitlab/config/resque.yml
	 sudo -u git sed -i 's/username: git/username: gitlab/g' /home/git/gitlab/config/database.yml
	 sudo -u git sed -i 's/password: "secure password"/password: "gitlab"/g' /home/git/gitlab/config/database.yml
	 sudo -u git sed -i 's/port: 80/port: 8080/g' /home/git/gitlab/config/gitlab.yml
	 sudo -u git -H chmod o-rwx /home/git/gitlab/config/database.yml
	 chown -R git /home/git/gitlab/log/
	 chown -R git /home/git/gitlab/tmp/
	 chmod -R u+rwX  /home/git/gitlab/log/
	 chmod -R u+rwX  /home/git/gitlab/tmp/
	 sudo -u git -H mkdir /home/git/gitlab-satellites
	 sudo chmod u+rwx,g=rx,o-rwx /home/git/gitlab-satellites
	 sudo -u git -H mkdir -p /home/git/gitlab/tmp/pids/
	 sudo -u git -H mkdir -p /home/git/gitlab/tmp/sockets/
	 chmod -R u+rwX  /home/git/gitlab/tmp/pids/
	 chmod -R u+rwX  /home/git/gitlab/tmp/sockets/
	 sudo -u git -H mkdir -p /home/git/gitlab/public/uploads
	 chmod -R u+rwX  /home/git/gitlab/public/uploads

	 # Post-Insall Git
	 sudo -u git -H git config --global user.name "GitLab"
	 sudo -u git -H git config --global user.email "gitlab@localhost"
	 sudo -u git -H git config --global core.autocrlf input
	 gem install charlock_holmes -v '0.7.3'
	 gem install rack -v '1.5.4'
	 su git -c "cd /home/git/gitlab && bundle install --deployment --without development test postgres aws"
	 # let's get rid of the security question
	 sed -i 's/listen "127.0.0.1:8080"/listen "127.0.0.1:8081"/g' /home/git/gitlab/config/unicorn.rb
	 sed -i 's/answer = prompt(\"Do you want to continue (yes\/no)? \".blue, \%w{yes no})/answer =\"yes\"/g' /home/git/gitlab/lib/tasks/gitlab/task_helpers.rake
	  
	 # Setup Git and Webpage
	 cp /home/git/gitlab/lib/support/nginx/gitlab /etc/nginx/sites-available/gitlab
	 ln -s /etc/nginx/sites-available/gitlab /etc/nginx/sites-enabled/gitlab
	 sed -i 's/YOUR_SERVER_FQDN/localhost/g' /etc/nginx/sites-available/gitlab
	 sed -i 's/:80/:8080/g' /etc/nginx/sites-available/gitlab
	 sudo -u git -H bash -c "cd /home/git/gitlab && bundle exec rake gitlab:setup RAILS_ENV=production"
	 sudo -u git -H bash -c "cd /home/git/gitlab && bundle exec rake assets:precompile RAILS_ENV=production"
	 /etc/init.d/nginx restart
	 sudo cp /home/git/gitlab/lib/support/logrotate/gitlab /etc/logrotate.d/gitlab           # setup log rotation
	 sudo cp /home/git/gitlab/lib/support/init.d/gitlab /etc/init.d/gitlab  # make git start at boot
	 sudo update-rc.d gitlab defaults 21
	 
	 # Execute Kernel Setup
	 pip install bash_kernel 
	 chown vagrant:vagrant -R /home/vagrant/
	 sudo -H -u vagrant bash -c "cd /home/vagrant && cat /home/vagrant/r_install.script | R --no-save >> /home/vagrant/r_install.log 2>&1"
	 cd /home/vagrant/kernel_node/package && sudo -u vagrant -H npm install
	 cd /home/vagrant/kernel_node/package && sudo -u vagrant -H node install.js
	 # cd /home/vagrant/IHaskell && ihaskell install
	 # gem install iruby  
	 ipython profile create iocaml
	 pip install redis_kernel 
	 pip install pandas boilerpipe bokeh feedparser nltk BeautifulSoup scipy scikit-learn PyOpenGL networkx
	 pip3 install pandas boilerpipe bokeh feedparser nltk BeautifulSoup scipy scikit-learn PyOpenGL networkx
	 chown vagrant:vagrant -R /home/vagrant/

	 # Start sequence for applications and node-red nodes    
	 su vagrant -c "cd /home/vagrant/ && nohup node-red > /home/vagrant/node-red.log 2>&1 &"
	 su vagrant -c "nohup rabbitmq-server > /home/vagrant/rabbitMQ.log 2>&1 &"
	 # Execute node-red setup
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-sqlite > /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-mysql >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-redis >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-xmpp >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-irc >> /home/vagrant/node-install.log"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/.node-red && npm install node-red-node-stomp >> /home/vagrant/node-install.log"
	 pkill node-red ## Workaround to get node-red additional nodes activated
	 su vagrant -c "cd /home/vagrant/notebooks && nohup node-red > /home/vagrant/node-red.log 2>&1 &"
	 su vagrant -c "cd /home/vagrant/notebooks && nohup ipython notebook --ip=0.0.0.0 --no-browser > /home/vagrant/ipython.log 2>&1 &"
	 pkill ipython ## Workaround to get R kernel activated
	 # Activate R Kernel for iPython
	 su vagrant -c "cd /home/vagrant &&echo 'IRkernel::installspec()' |  R --no-save >> /home/vagrant/r_install.log 2>&1"
	 
	 # Add Python 3
	 sudo -H -u vagrant bash -c "ipython kernelspec install-self --user"
	 sudo -H -u vagrant bash -c "cp -R /home/vagrant/.ipython/kernels/python2/ /home/vagrant/.ipython/kernels/python3"
	 echo ' { "display_name": "Python 3",  ' > /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"language": "python", ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"argv": [ ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"python3", ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"-c", "from IPython.kernel.zmq.kernelapp import main; main()", ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"-f", "{connection_file}"' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '], ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"codemirror_mode": {' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"version": 2, ' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '"name": "ipython"' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 echo '}  }' >> /home/vagrant/.ipython/kernels/python3/kernel.json
	 chown vagrant:vagrant -R /home/vagrant/.ipython/kernels/
	 sudo -H -u vagrant bash -c "git clone https://github.com/matplotlib/matplotlib --depth=1"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/matplotlib && python3 setup.py build"
	 sudo cd /home/vagrant/ && python3 setup.py install
	 # Starting up some stuff
	 service mysql restart
	 su git -c "/etc/init.d/gitlab restart"
	 su vagrant -c "echo 'Access to gitlab: root, pass: 5iveL!fe' > /home/vagrant/readme.gitlab"
	 
	 ## Get Hugo
	 cd /tmp && wget https://github.com/spf13/hugo/releases/download/v0.14/hugo_0.14_amd64.deb
	 dpkg -i hugo_0.14_amd64.deb
	 sudo -H -u vagrant bash -c "mkdir -p /home/vagrant/notebooks/hugo_pages/test"
	 sudo -H -u vagrant bash -c "hugo new site /home/vagrant/notebooks/hugo_pages/test"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/notebooks/hugo_pages/test && git clone --recursive https://github.com/spf13/hugoThemes.git themes"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/notebooks/hugo_pages/test && hugo new about.md"
	 # sudo -H -u vagrant bash -c "cd /home/vagrant/notebooks/hugo_pages/test && hugo -t hugoscroll"
	 echo "Hello, this is your Hugo installation running!" >>  /home/vagrant/notebooks/hugo_pages/test/content/about.md
	 sudo -H -u vagrant bash -c "cd /home/vagrant/ && nohup hugo server -s /home/vagrant/notebooks/hugo_pages/test --theme=hyde --watch -p 11313 --bind=0.0.0.0  --appendPort=true --buildDrafts &"
	 
	 # Nearly finished, install some magic
	 su vagrant -c "mkdir -p /home/vagrant/magic"
	 su vagrant -c "cd /home/vagrant/ && git clone https://github.com/cjdrake/ipython-magic" # Graphviz Magics (gvmagic.py): %dot, %dotstr, %dotobj, %dotobjs
	 cd /home/vagrant/ipython-magic && python setup.py install
	 
	 ## Finish off - download some examples
	 mkdir -p /home/vagrant/notebooks/examples
	 mkdir -p /home/vagrant/notebooks/howto
	 mkdir -p /home/vagrant/notebooks/tests
	 mkdir -p /home/vagrant/notebooks/sample_data
	 cd /home/vagrant/notebooks/examples && wget http://jakevdp.github.io/mpl_tutorial/_downloads/01_basic_plotting.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/plotly/IPython-plotly/master/notebooks/survival_analysis/survival_analysis.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/bigsnarfdude/bsides_vancouver_2013/master/PickleRedis.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/DavidPowell/openmodes-examples/master/Using%20and%20creating%20geometric%20shapes.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/bokeh/bokeh-notebooks/master/tutorial/02%20-%20charts.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/ptwobrussell/Mining-the-Social-Web-2nd-Edition/master/ipynb/Chapter%205%20-%20Mining%20Web%20Pages.ipynb
	 cd /home/vagrant/notebooks/examples && wget http://jakevdp.github.com/downloads/notebooks/XKCD_plots.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/justmarkham/DAT4/master/notebooks/08_linear_regression.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/jrjohansson/ipython-asymptote/master/examples/asymptote_magic_examples.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/ipython-books/cookbook-code/master/notebooks/chapter06_viz/06_vispy.ipynb
	 cd /home/vagrant/notebooks/examples && wget https://raw.githubusercontent.com/mbakker7/exploratory_computing_with_python/master/notebook1/py_exploratory_comp_1_sol.ipynb
	 cd /home/vagrant/notebooks/ && git clone https://github.com/ipython/ipython-in-depth.git --depth=1
	 chown -R vagrant:vagrant /home/vagrant/
	 
	 #
	 # Finally start ipython
	 su vagrant -c "cd /home/vagrant/notebooks && nohup ipython notebook --ip=0.0.0.0 --no-browser >> /home/vagrant/ipython.log 2>&1 &"
	 #
	 # python to show installed modules
	 # python -c 'import pip;  sorted(["%s==%s" % (i.key, i.version) for i in pip.get_installed_distributions()]);'
	 # python test for pyqt: from PyQt4 import QtCore, QtGui
	 # Info about gitlab: sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production
	 # Info about back-ends: import matplotlib.rcsetup as rcsetup
     # print(rcsetup.all_backends
	 #
	 #
	 #fluentd
	 echo "root soft nofile 65536" >> /etc/security/limits.conf
	 echo "root hard nofile 65536" >> /etc/security/limits.conf
	 echo "* soft nofile 65536" >> /etc/security/limits.conf
	 echo "* hard nofile 65536" >> /etc/security/limits.conf
	 # curl -L https://td-toolbelt.herokuapp.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
	 cd /tmp &&  wget http://packages.treasuredata.com/2/ubuntu/lucid/pool/contrib/t/td-agent/td-agent_2.2.0-0_amd64.deb
	 cd /tmp && dpkg -i td-agent_2.2.0-0_amd64.deb
	 /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-elasticsearch
	 /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-record-reformer
	 sed -i 's/port 8888/port 9999/g' /etc/td-agent/td-agent.conf
	 # let's log nginx
	 usermod -a -G adm td-agent
	 usermod -a -G www-data td-agent
	 echo "<source>" >>  /etc/td-agent/td-agent.conf
	 echo "type tail" >>  /etc/td-agent/td-agent.conf
	 echo "path /var/log/nginx/access.log #...or where you placed your Apache access log" >>  /etc/td-agent/td-agent.conf
	 echo "pos_file /var/log/td-agent/httpd-access.log.pos # This is where you record file position" >>  /etc/td-agent/td-agent.conf
	 echo "tag nginx.access #fluentd tag!" >>  /etc/td-agent/td-agent.conf
	 echo "format nginx # Do you have a custom format? You can write your own regex." >>  /etc/td-agent/td-agent.conf
	 echo "</source>" >>  /etc/td-agent/td-agent.conf
	 echo "<source>" >>  /etc/td-agent/td-agent.conf
	 echo "type tail" >>  /etc/td-agent/td-agent.conf
	 echo "path /var/log/nginx/gitlab_error.log #...or where you placed your Apache access log" >>  /etc/td-agent/td-agent.conf
	 echo "pos_file /var/log/td-agent/git-error.log.pos # This is where you record file position" >>  /etc/td-agent/td-agent.conf
	 echo "tag nginx.access #fluentd tag!" >>  /etc/td-agent/td-agent.conf
	 echo "format nginx # Do you have a custom format? You can write your own regex." >>  /etc/td-agent/td-agent.conf
	 echo "</source>" >>  /etc/td-agent/td-agent.conf
	 echo "<source>" >>  /etc/td-agent/td-agent.conf
	 echo "type tail" >>  /etc/td-agent/td-agent.conf
	 echo "path /var/log/nginx/gitlab_access.log #...or where you placed your Apache access log" >>  /etc/td-agent/td-agent.conf
	 echo "pos_file /var/log/td-agent/git-access.log.pos # This is where you record file position" >>  /etc/td-agent/td-agent.conf
	 echo "tag nginx.access #fluentd tag!" >>  /etc/td-agent/td-agent.conf
	 echo "format nginx # Do you have a custom format? You can write your own regex." >>  /etc/td-agent/td-agent.conf
	 echo "</source>" >>  /etc/td-agent/td-agent.conf	 
	 echo "<match **> " >>  /etc/td-agent/td-agent.conf
	 echo "type elasticsearch" >>  /etc/td-agent/td-agent.conf
	 echo "logstash_format true" >>  /etc/td-agent/td-agent.conf
	 echo "host localhost #(optional; )" >>  /etc/td-agent/td-agent.conf
	 echo "port 9200 #(optional; default=9200)" >>  /etc/td-agent/td-agent.conf
	 echo "index_name fluentd #(optional; default=fluentd)" >>  /etc/td-agent/td-agent.conf
	 echo "type_name fluentd #(optional; default=fluentd)" >>  /etc/td-agent/td-agent.conf
	 echo "</match>" >>  /etc/td-agent/td-agent.conf
	 /etc/init.d/td-agent restart
	 # test:  curl -X POST -d 'json={"json":"message"}' http://localhost:9999/debug.test
	 # elastic search
	 cd /tmp &&  wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.6.0.deb
	 cd /tmp &&  dpkg -i elasticsearch-1.6.0.deb
	 # test with: curl -X GET http://localhost:9200/
	 # kibana
	 cd /tmp && curl -L https://download.elastic.co/kibana/kibana/kibana-4.1.0-linux-x64.tar.gz | tar xzf -
	 cp -r /tmp/kibana-4.1.0-linux-x64 /opt
	 mv /opt/kibana-4.1.0-linux-x64 /opt/kibana
	 service elasticsearch start
	 # test: curl 'localhost:9200/_cat/indices?v'
	 sudo -H -u vagrant bash -c "nohup  /opt/kibana/bin/kibana >> /home/vagrant/kibana.log 2>&1"
	 /etc/init.d/td-agent restart
	 mkdir /mnt/share
	 mount -t vboxsf vagrant /mnt/share
	 echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg
	 dpkg-reconfigure -f noninteractive cloud-init
 