#!/bin/bash

#[CONFIG]

#[ssh]
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -i -e 's/bind 127.0.0.1/#bind 127.0.0.1/g' /etc/redis/redis.conf

service redis-server restart

service rabbitmq-server start
service rabbitmq-server stop
service rabbitmq-server restart

rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu-user tZrYqCVPyR4b1t
rabbitmqctl set_permissions -p /sensu sensu-user ".*" ".*" ".*"

#cp -r /root/rabbitmq/ssl /etc/rabbitmq/ssl/
#cp /root/rabbitmq/rabbitmq.config /etc/rabbitmq/rabbitmq.config

service rabbitmq-server restart
service redis-server restart

mkdir /var/run/sshd
/usr/sbin/sshd -D

