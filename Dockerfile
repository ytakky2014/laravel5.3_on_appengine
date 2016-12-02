FROM php:7-apache

COPY /conf/laravel.conf /etc/apache2/sites-enabled/000-default.conf
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN mkdir -p  /app/AccessLog.local && chmod 777 /app/AccessLog.local
RUN mkdir -p /app/laravel5.3 && chmod 777 /app/laravel5.3

ADD app/ /app/laravel5.3
RUN apt-get update
RUN apt-get install -y vim git zip unzip

RUN chmod -R 777 /app/laravel5.3/storage && chmod -R 777 /app/laravel5.3/bootstrap/cache
RUN cd /app/laravel5.3 && composer update
COPY /conf/ports.conf /etc/apache2/ports.conf

EXPOSE 8080