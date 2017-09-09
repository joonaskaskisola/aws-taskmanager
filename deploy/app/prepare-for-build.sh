#!/bin/bash

echo "- Switching to application/";
cd application/

echo "- Clearing local cache";
rm -rf app/cache/*

echo "- Inserting configs";
source conf/insert-configs.sh

#echo "- Fetching master"
#git fetch --all
#git reset --hard origin/master

echo "- Updating composer packages";
composer update

echo "- Updating npm packages";
npm install

echo "- Running webpack";
webpack -p --colors --progress

#echo "- Updating database";
#cd app/
#php doctrine:schema:update --force

rm -rf app/cache/*
