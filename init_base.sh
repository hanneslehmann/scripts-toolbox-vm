#!/usr/bin/env bash
echo "Starting base install..." >> /var/log/bootstrap.log
apt-get update
apt-get upgrade -y
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string localhost" | debconf-set-selections
echo "postfix postfix/destinations string toolbox.local, localhost" | debconf-set-selections
apt-get install -y postfix
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
apt-get install -y git ant nano curl ca-certificates mercurial make binutils bison gcc build-essential g++ cmake nginx python-software-properties software-properties-common
add-apt-repository ppa:marutter/rrutter -y
sudo apt-get update
apt-get install -f
apt-get install -y pandoc mosquitto mosquitto-clients mysql-server mysql-client libmysqlclient-dev  graphviz bzr expect libxext-dev libfreetype6-dev  
apt-get install -y  lua5.2 liblua5.2-dev luarocks
apt-get install -y   python-zmq python-dev python-matplotlib python2.7-dev python-pip python3-pip  python-qt4 qt4-dev-tools
apt-get install -y libzmq3-dev
apt-get install -y  r-base ghc r-cran-gplots haskell-platform opam 
apt-get install -y zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev git-core openssh-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev camlp4-extra m4 zlib1g-dev tk-dev python3-tk jq

pip install virtualenv
pip install virtualenvwrapper

apt-get clean

