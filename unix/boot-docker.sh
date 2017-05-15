#!/bin/bash

#Create project directory

if  [! -d ~/web/oniSystem/bin/console ] || [! -d ~/web ] ; then
    mkdir ~/web
    rm -r ~/web/oniSystem
    #Clone oni-system project
    git clone git@github.com:peteratkins85/OniManagmentSystem.git ~/web/oniSystem
fi

if ! grep -q oni-system.local "/etc/hosts"; then
   echo "127.0.0.1     oni-system.local" | sudo tee -a  /etc/hosts > /dev/null
fi

mkdir composer

docker-compose build

docker-compose up -d

docker exec -u www-data oni-system /var/www/init.sh