# laravel

FROM composer:lts

# Set the working directory in the container
WORKDIR /var/www/html

COPY my-app/ .

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip
    
# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install project dependencies
# RUN composer install --optimize-autoloader --no-dev

# RUN composer install

EXPOSE 9000

CMD ["php", "artisan", "serve"]
