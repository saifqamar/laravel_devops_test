# Use official PHP image with CLI and necessary extensions
FROM php:8.4-cli

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy Laravel project files
COPY . .

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Set appropriate permissions for storage and cache
RUN chmod -R 777 storage bootstrap/cache

# Set Laravel environment

ENV APP_DEBUG=false

# Command to start the Laravel application
CMD ["php", "artisan", "serve"]

# Expose application port
EXPOSE 8000
