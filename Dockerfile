FROM debian:jessie
MAINTAINER Jean-Avit Promis "docker@katagena.com"

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install php5 php5-cli php5-curl curl git apache2 libapache2-mod-php5 php5-gd php5-imagick php5-intl php5-mcrypt php5-xdebug php5-apcu memcached php5-memcached && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN php /usr/local/bin/composer self-update

RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

COPY init.sh /init.sh
RUN chmod +x /init.sh

ENV SYMFONY_ENV production
ENV SYMFONY_DIRECTORY /var/www/
ENV APACHE_VHOST 000-default

##Apache
RUN a2enmod rewrite
RUN a2dissite 000-default
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

VOLUME /etc/apache2/sites-available
CMD /init.sh
