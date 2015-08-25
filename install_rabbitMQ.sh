#!/usr/bin/env bash
echo "Starting RabbitMQ install..." >> /var/log/bootstrap.log
apt-get install -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config
rabbitmq-server restart
pip install pika
