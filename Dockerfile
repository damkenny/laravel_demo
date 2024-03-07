# # laravel
# FROM php:8.0
# RUN apt-get update -y && apt-get install -y openssl zip unzip git
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN add-apt-repository ppa:ondrej/php && apt-get update
# RUN docker-php-ext-install pdo mbstring
# WORKDIR /app
# COPY /my-app .
# RUN composer install

# CMD php artisan serve --host=0.0.0.0 --port=8181
# EXPOSE 8181


# php composer-setup.php --2.2

FROM php:8.0

# Set the working directory in the container
WORKDIR /app
COPY my-app/ .
# Install dependencies
# FROM php:8.0
RUN apt-get update -y && apt-get install -y openssl zip unzip git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN docker-php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN docker-composer-setup.php
RUN docker-php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

RUN docker-php-ext-install pdo mbstring
RUN composer install
EXPOSE 8181

CMD php artisan serve --host=0.0.0.0 --port=8181
