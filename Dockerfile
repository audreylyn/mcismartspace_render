# Use PHP 8.1 with Apache
FROM php:8.1-apache

# 1. Install the PHP extensions for MySQL
# This is ESSENTIAL for your database connection to work.
RUN docker-php-ext-install mysqli pdo pdo_mysql

# 2. Configure Apache to listen on Render's port (10000)
ENV PORT=10000
RUN sed -i "s/80/\$PORT/g" /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# 3. Enable mod_rewrite for .htaccess files (good practice)
RUN a2enmod rewrite

# 4. Copy your application code to the web root
COPY . /var/www/html/

# 5. Set correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html/

# 6. Expose the port
EXPOSE $PORT
