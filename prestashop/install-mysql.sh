#! /bin/bash

db_password=$1
db_user=root
db_name=prestashop

apt-get -y update

logger "Configuring disks"

MOUNT_POINT="/datadisks/disk1"

# Stripe all the datadisks
bash ./vm-disk-utils-0.1.sh -s

# Point the MySQL base dir to the striped disk
mkdir "${MOUNT_POINT}/mysql"
ln -s "${MOUNT_POINT}/mysql" /var/lib/mysql

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

mysql -u $db_user -p$db_password --execute="GRANT ALL ON *.* to $db_user@'localhost' IDENTIFIED BY '$db_password'; " 2> /dev/null;
mysql -u $db_user -p$db_password --execute="GRANT ALL ON *.* to $db_user@'%' IDENTIFIED BY '$db_password'; " 2> /dev/null;
mysql -u $db_user -p$db_password --execute="flush privileges; " 2> /dev/null;

service mysql restart

logger "MySQL installed"