FROM ubuntu:trusty

RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

RUN echo "root:C7-yny7tZrYqCVPy" | chpasswd

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update --fix-missing && DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y apt-utils apt-transport-https lsb-release ca-certificates wget curl python-software-properties software-properties-common openssh-server

RUN wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | sudo apt-key add -

RUN echo "deb     https://sensu.global.ssl.fastly.net/apt trusty main" | sudo tee /etc/apt/sources.list.d/sensu.list

RUN apt-get update

RUN apt-get install -y sensu uchiwa vim nagios-plugins git

RUN mkdir /opt/sensu-metrics-relay

RUN git clone https://github.com/opinionlab/sensu-metrics-relay.git /opt/sensu-metrics-relay

RUN mkdir /etc/sensu/ssl

ADD ./dockinit.sh /root/dockinit.sh

RUN chmod +x /root/dockinit.sh
ENTRYPOINT ["/root/dockinit.sh"]

#[EXPOSE] Expose ports to the host machine
expose 4567 3000  3030

CMD ["/usr/bin/ssh", "-D"]

