FROM jkaninda/nginx-php-fpm:8.3

# Set working directory
WORKDIR /var/www/html



# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application files
COPY . .


# Overwriting nginx default configurtaion
COPY default.conf /etc/nginx/conf.d/default.conf

# Install Composer dependencies
RUN composer install --no-dev --no-interaction --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 storage \
    && chmod -R 775 bootstrap/cache

# Expose port
EXPOSE 80

# Start PHP-FPM when the container is run
CMD ["php-fpm"]
