#! /bin/bash

db_password=$1
db_user=root
db_name=prestashop

apt-get -y update

logger "Installing MySQL"

export DEBIAN_FRONTEND=noninteractive

# Initialize components
echo mysql-server-5.6 mysql-server/root_password password $db_password | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password $db_password | debconf-set-selections

apt-get -y install mysql-server mysql-client

if [ "$db_password" == "" ]; then
	mysqladmin -u$DB_USER create $db_name --force;
else
	mysqladmin -u$db_user -p$db_password create $db_name --force;
fi

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnfs

mysql -u $db_user -p$db_password --execute="GRANT ALL ON *.* to $db_user@'localhost' IDENTIFIED BY '$db_password'; " 2> /dev/null;
mysql -u $db_user -p$db_password --execute="GRANT ALL ON *.* to $db_user@'%' IDENTIFIED BY '$db_password'; " 2> /dev/null;
mysql -u $db_user -p$db_password --execute="flush privileges; " 2> /dev/null;

service mysql restart

logger "MySQL installed"