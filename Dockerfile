FROM php:8.2-apache
#COPY src/ /var/www/html/

RUN apt-get update && apt-get install -y nano zip unzip libzip-dev

RUN docker-php-ext-install zip && docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql


RUN mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak
COPY laravel-apache2.conf  /etc/apache2/sites-available/000-default.conf

# Instalamos composer, si utilizamos algun framework como symfony nos hara falta
RUN curl https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

# Nodejs 20
RUN apt-get update
RUN apt-get install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install nodejs -y

# Le decimos que escuche en el puerto 80 para el servidor Web
EXPOSE 80

