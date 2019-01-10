#!/bin/bash

#[CONFIG]

#[ssh]
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

cpcmd=`which cp`

#if [ -d "/etc/sensu/ssl" ];
#then
#
#	$cpcmd /root/cacert.pem /etc/sensu/ssl/cacert.pem
#	$cpcmd /root/cert.pem /etc/sensu/ssl/cert.pem
#	$cpcmd /root/key.pem /etc/sensu/ssl/key.pem
#fi

if [ -d "/opt/sensu-metrics-relay" ];
then

       $cpcmd /opt/sensu-metrics-relay/lib/sensu/extensions/* /etc/sensu/extensions
fi

rccmd=`which update-rc.d`

if [ $rccmd != "" ];
then
	$rccmd sensu-server defaults
	$rccmd sensu-client defaults
	$rccmd sensu-api defaults
	$rccmd uchiwa defaults
fi

if [ -d "/opt/sensu/embedded/bin/" ];
then
	cd /opt/sensu/embedded/bin/
	sensu-install -p cpu-checks  
	sensu-install -p disk-checks  
	sensu-install -p memory-checks  
	sensu-install -p nginx  
	sensu-install -p process-checks  
	sensu-install -p load-checks  
	sensu-install -p vmstats  
	sensu-install -p mailer
fi


#if [ -d "/etc/sensu/conf.d" ];
#then
#	$cpcmd /root/rabbitmq.json /etc/sensu/conf.d/rabbitmq.json
#	$cpcmd /root/redis.json /etc/sensu/conf.d/redis.json
#	$cpcmd /root/api.json /etc/sensu/conf.d/api.json
#	$cpcmd /root/client.json /etc/sensu/conf.d/client.json
#	$cpcmd /root/uchiwa.json /etc/sensu/uchiwa.json
#fi

servcmd=`which service`

$servcmd uchiwa start
$servcmd sensu-server start
$servcmd sensu-api start
$servcmd sensu-client start

if [ ! -d "/var/run/sshd" ];
then 
	mkdir /var/run/sshd
fi

/usr/sbin/sshd -D

