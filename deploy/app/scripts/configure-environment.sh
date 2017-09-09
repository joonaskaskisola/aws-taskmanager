#!/usr/bin/env bash

source /opt/php-webservice/conf/insert-configs.sh

sed -e "s/_REPLACE_MEMCACHE_SERVER_/$MEMCACHEDCLOUD_SERVERS/g" -i /etc/php/7.1/fpm/php.ini
