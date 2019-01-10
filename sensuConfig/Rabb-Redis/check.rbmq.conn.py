#!/usr/bin/env python
# Dependecies: 
# apt-get install python-pip;
# pip install kombu

import socket
from kombu import Connection


host = "::1"
port = 5671
user = "sensu-user"
password = "tZrYqCVPyR4b1t"
vhost = "/sensu"
url = 'amqp://{0}:{1}@{2}:{3}/{4}'.format(user, password, host, port, vhost)
with Connection(url) as c:
    try:
        c.connect()
    except socket.error:
        raise ValueError("Received socket.error, "
                         "rabbitmq server probably isn't running")
    except IOError:
        raise ValueError("Received IOError, probably bad credentials")
