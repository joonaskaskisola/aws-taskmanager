#!/bin/bash

if [ -f /etc/nginx/nginx.conf ]; then
	rm /etc/nginx/nginx.conf
fi

if [ -f /etc/php/7.1/fpm/pool.d/www.conf ]; then
	rm /etc/php/7.1/fpm/pool.d/www.conf
fi

if [ -f /etc/php/7.1/fpm/php.ini ]; then
	rm /etc/php/7.1/fpm/php.ini
fi

if [ -f /opt/php-webservice/app/config/config_dev.yml ]; then
	rm /opt/php-webservice/app/config/config_dev.yml
fi
