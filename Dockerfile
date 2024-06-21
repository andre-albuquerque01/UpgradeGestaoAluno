# Use imagem oficial do PHP com suporte ao FPM
FROM php:8.0-fpm

# Instale dependências necessárias
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    supervisor \
    nginx \
    libcurl4-openssl-dev  # Adicione libcurl

# Instale extensões PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd curl

# Configuração do Nginx
COPY ./nginx/default.conf /etc/nginx/sites-available/default

# Copie o projeto
WORKDIR /var/www
COPY . .

# Certifique-se de que o diretório storage existe e ajuste as permissões
RUN mkdir -p /var/www/storage && chown -R www-data:www-data /var/www && chmod -R 755 /var/www/storage

# Exponha a porta 80 para Nginx
EXPOSE 80

# Start supervisord para gerenciar PHP-FPM e Nginx
COPY ./supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]