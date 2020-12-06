#!/bin/bash
sudo echo "127.0.0.1 `hostname`" >> /etc/hosts
sudo apt-get update -y
sudo apt-get install mysql-client -y
sudo apt-get install apache2 apache2-utils -y
sudo apt-get install php libapache2-mod-php php-mbstring php-xml php-mysql php-common php-gd php-bcmath php-intl php-json php-cli php-curl php7.4-zip -y
sudo wget -c http://wordpress.org/wordpress-5.1.1.tar.gz
sudo tar -xzvf wordpress-5.1.1.tar.gz
sudo mkdir -p /var/www/html/
sudo rsync -av wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo cp -f /tmp/wp-config.php /var/www/html/wp-config.php
sudo rm /var/www/html/index.html
sudo systemctl restart apache2