#!/usr/bin/env bash
echo "Starting gitlab install..." > /var/log/bootstrap.log

    apt-get install -y libkrb5-dev

	 ## setup MySQL for GitLab and access from external (e.g. Workbench)
	 # create script
	 echo "CREATE USER 'gitlab'@'localhost' IDENTIFIED BY 'gitlab';" > /home/vagrant/git_setup.sql
	 echo "CREATE DATABASE IF NOT EXISTS \`gitlabhq_production\` DEFAULT CHARACTER SET \`utf8\` COLLATE \`utf8_unicode_ci\`;" >> /home/vagrant/git_setup.sql
	 echo "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON \`gitlabhq_production\`.* TO 'gitlab'@'localhost';" >> /home/vagrant/git_setup.sql
	 echo "CREATE USER 'tester'@'localhost' IDENTIFIED BY 'test';" >> /home/vagrant/git_setup.sql
	 echo "CREATE DATABASE IF NOT EXISTS \`test_db\` DEFAULT CHARACTER SET \`utf8\` COLLATE \`utf8_unicode_ci\`;" >> /home/vagrant/git_setup.sql
	 echo "GRANT SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, DROP, CREATE, DROP, INDEX, ALTER ON \`test_db\`.* TO 'tester'@'%';" >> /home/vagrant/git_setup.sql
	 echo "CREATE TABLE \`test_db\`.\`test\` (\`test\` int(11) NOT NULL, PRIMARY KEY (\`test\`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;" >> /home/vagrant/git_setup.sql
	 echo "Insert into \`test_db\`.test VALUES(1)" >> /home/vagrant/git_setup.sql
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

	 ## Create needed accounts
	 adduser --disabled-login --gecos 'GitLab' git
	
	 # prepare
     gem install timfel-krb5-auth -v '0.8.3'
	
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
	 sudo -u git sed -i 's/unix:\/var\/run\/redis\/redis.sock/\/tmp\/redis.sock/g' /home/git/gitlab/config/resque.yml
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
	 sudo -u git -H bash -c "cd /home/git/gitlab && bundle exec install"
	 sudo -u git -H bash -c "cd /home/git/gitlab && bundle exec rake gitlab:setup RAILS_ENV=production"
	 sudo -u git -H bash -c "cd /home/git/gitlab && bundle exec rake assets:precompile RAILS_ENV=production"
	 /etc/init.d/nginx restart
	 cp /home/git/gitlab/lib/support/logrotate/gitlab /etc/logrotate.d/gitlab           # setup log rotation
	 cp /home/git/gitlab/lib/support/init.d/gitlab /etc/init.d/gitlab  # make git start at boot
	 update-rc.d gitlab defaults 21
	 sudo -u git -H bash -c "/etc/init.d/gitlab restart"