#!/usr/bin/env bash
echo "Starting install and configure Ruby..." >> /var/log/bootstrap.log
## Install ruby
apt-get remove ruby
mkdir -p /tmp/ruby && cd /tmp/ruby && curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz | sudo tar xz
cd /tmp/ruby/ruby-2.1.5 && ./configure --disable-install-rdoc
cd /tmp/ruby/ruby-2.1.5 && make
cd /tmp/ruby/ruby-2.1.5 && sudo make install
gem install bundler --no-ri --no-rdoc
rm -rf /tmp/ruby *