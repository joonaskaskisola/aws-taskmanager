#!/usr/bin/env bash

export INSTANCE_ID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
export REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region`
export TAGS=`aws ec2 describe-instances --instance-ids $INSTANCE_ID --region $REGION | \
jq -r '.Reservations[0].Instances[0].Tags[] | {(.Key): .Value}' | \
jq -s -r 'reduce .[] as $item ({}; . * $item)'`
export STACKNAME=`echo $TAGS | jq -r .[\"aws:cloudformation:stack-name\"]`

export STACKOUTPUT=`aws cloudformation describe-stacks --stack-name $STACKNAME --region $REGION | \
jq -r '.Stacks[0].Outputs | .[] | {(.OutputKey): .OutputValue}' | \
jq -s -r 'reduce .[] as $item ({}; . * $item)'`

export MEMCACHED=$(echo ${STACKOUTPUT}|jq -r '.Memcached');
export MEMCACHED_HOST=$(echo ${MEMCACHED}|cut -d ':' -f1);

export DATABASE_URL=$(echo ${STACKOUTPUT}|jq -r '.RDSInstance');
export DATABASE_HOST=$(echo ${DATABASE_URL}|cut -d ':' -f1);

sed -e "s/_REPLACE_MYSQL_HOST_/$DATABASE_HOST/g" -i /opt/php-webservice/app/config/parameters.yml
sed -e "s/_REPLACE_MYSQL_USER_/admin/g" -i /opt/php-webservice/app/config/parameters.yml
sed -e "s/_REPLACE_MYSQL_PASSWD_/admin123/g" -i /opt/php-webservice/app/config/parameters.yml
sed -e "s/_REPLACE_MEMCACHED_HOST_/$MEMCACHED_HOST/g" -i /opt/php-webservice/app/config/parameters.yml
sed -e "s/_REPLACE_MEMCACHE_SERVER_/$MEMCACHED/g" -i /etc/php/7.1/fpm/php.ini

cd /opt/php-webservice/app/

rm -rf cache/*

php console doctrine:database:create && \
    php console doctrine:schema:update --force && \
    php console seed:load

php console doctrine:schema:update --force > /dev/null
