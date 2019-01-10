FROM mysql:5.7

#RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV MYSQL_ROOT_PASSWORD=TtgZRe9XsBL9meX4
ENV MYSQL_ROOT_HOST=%

ADD graphitedb.sql /docker-entrypoint-initdb.d/graphitedb.sql

EXPOSE 3306

CMD ["mysqld"]

