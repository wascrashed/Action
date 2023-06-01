# Используйте базовый образ PHP с поддержкой Apache
FROM php:8.1.9-apache

# Установите необходимые расширения PHP
RUN docker-php-ext-install pdo pdo_mysql

# Установите composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Установите расширение Apache для обработки .htaccess файлов
RUN a2enmod rewrite

# Копируйте исходный код приложения в контейнер
COPY . /var/www/html

#Установка зависимостей Composer с переменной окрудения COMPOSER_ALLOW_SUPERUSER=1
RUN composer install

# Установите правильные разрешения на папку хранения кэша Laravel
RUN chown -R www-data:www-data storage

# Запустите веб-сервер Apache
CMD ["apache2-foreground"]
