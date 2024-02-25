# Base image with PHP and Nginx
FROM php:8.1-apache

# Set working directory
WORKDIR /var/www/html

# Copy composer.json and composer.lock
COPY composer.json composer.lock .

# Install dependencies
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    pdo-mysql \
    mysqli \
    libxml2-dev \
    libcurl4-openssl-dev \
    unzip

# Install Composer and use it to install project dependencies
RUN composer install --no-interaction --prefer-dist

# Copy application code
COPY . .

# Expose web server port
EXPOSE 80

# Configure environment variables
ENV APP_ENV production
ENV APP_URL http://localhost:80

# Start the Nginx server
CMD ["apache2-foreground"]
