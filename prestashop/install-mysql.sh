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

apt-get -y install mysql-server

if [ "$db_password" == "" ]; then
	mysqladmin -u$db_user create $db_name --force;
else
	mysqladmin -u$db_user -p$db_password create $db_name --force;
fi

logger "MySQL installed"