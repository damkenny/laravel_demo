FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip

RUN docker-php-ext-install -y pdo mbstring bcmath xml soap

WORKDIR /var/www/html

COPY my-app/ .

RUN composer install --no-interaction --prefer-dist

EXPOSE 80

CMD ["php", "artisan", "serve", "--host", "0.0.0.0", "--port", "80"]
