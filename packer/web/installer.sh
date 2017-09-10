#!/bin/bash

sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.1-cli php7.1-common php7.1-curl php7.1-intl php7.1-json \
	php7.1-mbstring php7.1-mcrypt php7.1-pgsql php7.1-readline php7.1-soap \
	php7.1-sqlite3 php7.1-xml php7.1-zip php7.1-xsl wget ruby awscli php7.1-fpm nginx\
	php7.1-mysql php-memcached php-memcache jq
cd /tmp
wget https://aws-codedeploy-eu-west-1.s3.amazonaws.com/latest/install -O install.sh
chmod +x install.sh
sudo ./install.sh auto
sudo service codedeploy-agent status
sudo service codedeploy-agent start
rm install.sh
