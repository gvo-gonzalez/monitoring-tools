#!/bin/bash

#[CONFIG]

#[ssh]
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#sudo rabbitmqctl add_vhost sensu
#sudo rabbitmqctl add_user sensu-user tZrYqCVPyR4b1t
#sudo rabbitmqctl set_permissions -p sensu sensu-user ".*" ".*" ".*"


#sudo mkdir /etc/rabbitmq/ssl/
#sudo service rabbitmq-server stop

#sudo cp /root/cacert.pem /etc/rabbitmq/ssl/
#sudo cp /root/cert.pem /etc/rabbitmq/ssl
#sudo cp /root/key.pem /etc/rabbitmq/ssl

sudo cp /root/rabbitmq.config /etc/rabbitmq/rabbitmq.config

#sudo service rabbitmq-server restart
#sudo service redis-server restart

mkdir /var/run/sshd
/usr/sbin/sshd -D

