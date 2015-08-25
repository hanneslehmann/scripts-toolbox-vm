#!/usr/bin/env bash
echo "Starting install and configure Redis..." >> /var/log/bootstrap.log
apt-get install -y redis-server
# configure redis
unixsocket /tmp/redis.sock
sed -i 's/# unixsocket/unixsocket/g'  /etc/redis/redis.conf
# sed -i 's/\/tmp\/redis.sock/\/var\/run\/redis\/redis.sock/g'  /etc/redis/redis.conf
# sed -i 's/# unixsocketperm 755/unixsocketperm 766/g'  /etc/redis/redis.conf
# sed -i 's/# unixsocketperm 700/unixsocketperm 766/g'  /etc/redis/redis.conf
echo "unixsocketperm 766" >>  /etc/redis/redis.conf
#mkdir -p /var/run/redis
#chown redis:redis /var/run/redis
/etc/init.d/redis-server restart
pip install redisco