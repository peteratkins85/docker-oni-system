#!/bin/bash

cd /var/www/oniSystem

composer install

ln -s ./vendor/oni-sys/ Oni

bin/console doctrine:schema:update --force
bin/console doctrine:fixtures:load

