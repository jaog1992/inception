#!/bin/bash

# Ensure MySQL data directory exists and has correct permissions
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
chmod 777 /var/run/mysqld

# Configure MariaDB to allow external connections
sed -i 's/^socket\s*=.*/socket=\/var\/run\/mysqld\/mysqld.sock/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/^bind-address\s*=.*/#bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/skip-networking/#skip-networking/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/#\?port\s*=.*/port=3306/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize MySQL data directory if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Change the owner of MariaDB data directory
chown -R mysql /var/lib/mysql

/etc/init.d/mariadb restart
chmod +x /tmp/create.sh
service mariadb restart