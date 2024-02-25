# laravel

FROM php:8.1-fpm

COPY my-app/ .

RUN apt-get update \
    apt-get install -y composer

WORKDIR /var/www/html

RUN composer install

EXPOSE 80

CMD ["php", "artisan", "serve"]
