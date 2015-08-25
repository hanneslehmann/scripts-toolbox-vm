#!/usr/bin/env bash
echo "Starting HUGO install..." >> /var/log/bootstrap.log

	 ## Get Hugo
	 cd /tmp && wget https://github.com/spf13/hugo/releases/download/v0.14/hugo_0.14_amd64.deb
	 dpkg -i /tmp/hugo_0.14_amd64.deb
	 sudo -H -u vagrant bash -c "mkdir -p /home/vagrant/notebooks/hugo_pages/test"
	 sudo -H -u vagrant bash -c "hugo new site /home/vagrant/notebooks/hugo_pages/test"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/notebooks/hugo_pages/test && git clone --recursive https://github.com/spf13/hugoThemes.git themes"
	 sudo -H -u vagrant bash -c "cd /home/vagrant/notebooks/hugo_pages/test && hugo new about.md"
	 # sudo -H -u vagrant bash -c "cd /home/vagrant/notebooks/hugo_pages/test && hugo -t hugoscroll"
	 echo "Hello, this is your Hugo installation running!" >>  /home/vagrant/notebooks/hugo_pages/test/content/about.md
	 sudo -H -u vagrant bash -c "cd /home/vagrant/ && nohup hugo server -s /home/vagrant/notebooks/hugo_pages/test --theme=hyde --watch -p 11313 --bind=0.0.0.0  --appendPort=true --buildDrafts &"