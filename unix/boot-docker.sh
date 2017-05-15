#!/bin/bash

#Create project directory

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ~/

if  [! -d "web/oniSystem" ] || "web" ; then
    mkdir ~/web
fi

#Clone oni-system project
git clone git@github.com:peteratkins85/OniManagmentSystem.git ~/web/oniSystem


if ! grep -q oni-system.local "/etc/hosts"; then
   echo "127.0.0.1     oni-system.local" | sudo tee -a  /etc/hosts > /dev/null
fi

cd $DIR/../

mkdir composer

docker-compose build

docker-compose up -d

docker exec -u www-data oni-system /var/www/init.sh