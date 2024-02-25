# laravel

FROM php:8.1-fpm

RUN apt update \
    apt install -y composer

COPY my-app/ .


WORKDIR /var/www/html

RUN composer install

EXPOSE 80

CMD ["php", "artisan", "serve"]
