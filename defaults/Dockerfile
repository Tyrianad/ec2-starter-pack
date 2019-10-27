FROM php:7.2-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/site/public

RUN apt-get update && apt-get install -y                \
        libzip-dev                                      \
        unzip                                           \
        git                                          && \
    docker-php-ext-configure zip --with-libzip       && \
    docker-php-ext-install                              \
        zip pdo pdo_mysql                            && \
        a2enmod rewrite

RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

COPY site /var/www/html/
COPY .env /var/www/html/.env
RUN chmod -R 33:33 /var/www/html/site/storage

WORKDIR /var/www/html/site