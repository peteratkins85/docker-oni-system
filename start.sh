#!/bin/bash

chown -R www-data: $SYMFONY_DIRECTORY
cd $SYMFONY_DIRECTORY
mkdir -p /var/www/.composer
chown -R www-data: /var/www/.composer

su www-data -c "composer config -g github-oauth.github.com 775424d634ef40749f2c2585a2fef5c97279a14d"
/usr/sbin/apache2 -D FOREGROUND