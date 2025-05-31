FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -r -u 999 -s /sbin/nologin dbuser && \
    apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mysql/*

RUN mkdir -p /var/run/mysqld && \
    chown -R dbuser:dbuser /var/run/mysqld && \
    chown -R dbuser:dbuser /var/lib/mysql && \
    chmod 750 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./conf/create.sh /tmp/
COPY ./conf/init.sh /tmp/

RUN chmod +x /tmp/create.sh /tmp/init.sh && \
    chown -R dbuser:dbuser /tmp/create.sh /tmp/init.sh && \
    chown -R dbuser:dbuser /etc/mysql/

EXPOSE 3306

USER dbuser

CMD ["bash", "-c", "/tmp/init.sh && /tmp/create.sh && mysqld"]