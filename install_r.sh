#!/usr/bin/env bash
echo "Starting install R..." >> /var/log/bootstrap.log
	 ### Setup R
	 sudo -H -u vagrant bash -c "mkdir -p ~/.R/libs/"
	 sudo -H -u vagrant bash -c "echo 'R_LIBS=~/.R/libs/' > /home/vagrant/.Renviron"
	 echo 'options(repos=structure(c(CRAN="http://cran.rstudio.com")))' | tee /home/vagrant/.Rprofile
	 chown vagrant:vagrant /home/vagrant/.Rprofile
	 echo "install.packages(c('codetools', 'rzmq' ,'base64enc', 'evaluate', 'jsonlite', 'uuid', 'digest','ggplot2'))" > /home/vagrant/r_install.script
	 echo "install.packages(c('repr','IRkernel','IRdisplay','dplyr'), repos='http://irkernel.github.io/')" >> /home/vagrant/r_install.script
	 echo "install.packages(c('RMySQL','DBI','rmongodb','ngramr', 'ggplot2', 'rredis','devtools','OIsurv'))" >> /home/vagrant/r_install.script
	 echo "devtools::install_github('ropensci/plotly')" >> /home/vagrant/r_install.script
	 chown vagrant:vagrant /home/vagrant/r_install.script

	 # install.packages(c('survival','KMsurv','ggplot2'))