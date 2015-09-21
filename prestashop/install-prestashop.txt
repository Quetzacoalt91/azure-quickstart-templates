#! /bin/bash

apt-get -y update

apt-get -y install wget unzip

if [ "$ENV_REQUEST" == "nginx" ]; then
	root_path="/usr/share/nginx/www/";
else
	logger "Installing Apache + PHP"

	root_path="/var/www/html/";

	apt-get -y install apache2 php5 php5-mysql php5-mcrypt php5-curl php5-gd unzip
	a2enmod rewrite
	
	mv ./php.ini /etc/php5/apache2/php.ini
fi

logger "Downloading PrestaShop ..."


wget "https://www.prestashop.com/download/latest" -O prestashop.zip

logger "PrestaShop downloaded. Now preparing PrestaShop ..."

unzip -q prestashop.zip
mv prestashop/* $root_path

# rsync -a /tmp/prestashop/ $root_path

rmdir prestashop
rm prestashop.zip
cd $root_path
rm index.html

chown -R www-data:www-data $root_path;
chmod -R g+w $root_path;


logger "PrestaShop is ready to be installed !"