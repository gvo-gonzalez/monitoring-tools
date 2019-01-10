FROM ubuntu:trusty

RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

RUN echo "root:C7-yny7tZrYqCVPy" | chpasswd

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update --fix-missing && DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y apt-utils apt-transport-https lsb-release ca-certificates wget curl vim python-software-properties software-properties-common openssh-server sqlite3

RUN echo "deb https://packagecloud.io/grafana/stable/debian/ stretch main" | tee -a /etc/apt/sources.list.d/grafana.list

RUN curl -L -o /tmp/grafana-signing-key-public.key  https://packagecloud.io/gpg.key

RUN sudo apt-key add /tmp/grafana-signing-key-public.key

RUN apt-get update 
RUN apt-get install -y grafana

ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=admin

ADD ./config/grafana.ini /root/grafana.ini
ADD ./dockinit.sh /root/dockinit.sh

RUN chmod +x /root/dockinit.sh
ENTRYPOINT ["/root/dockinit.sh"]

#[EXPOSE] Expose ports to the host machine
expose 3000 

CMD ["/usr/bin/ssh", "-D"]
