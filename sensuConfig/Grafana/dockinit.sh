#!/bin/bash

#[CONFIG]

#[ssh]
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -i -e 's/bind 127.0.0.1/#bind 127.0.0.1/g' /etc/redis/redis.conf

mv /etc/grafana/grafana.ini /etc/grafana/grafana.ini.orig
cp /root/grafana.ini /etc/grafana/

service grafana-server start
service grafana-server stop
service grafana-server restart

update-rc.d grafana-server defaults 95  10

systemctl enable grafana-server.service
sqlite3 /var/lib/grafana/grafana.db "update user set password = '59acf18b94d7eb0694c61e60ce44c110c7a683ac6a8f09580d626f90f4a242000746579358d77dd9e570e83fa24faa88a8a6', salt = 'F3FAxVm33R' where login = 'admin'"
mkdir /var/run/sshd
/usr/sbin/sshd -D

