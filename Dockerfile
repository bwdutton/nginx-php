FROM alpine:3

RUN set -xe \
    && apk add --no-cache \
        ca-certificates \
	composer \
        gzip \
        nginx \
        openssl \
        php7-fpm \
        php7-common \
        php7-curl \
        php7-fileinfo \
        php7-json \
        php7-openssl \
        php7-mbstring \
        php7-mysqli \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-pear \
        php7-phar \
        php7-pgsql \
        php7-session \
        php7-sqlite3 \
        php7-xml \
        php7-xmlwriter \
        php7-zip \
        php7-zlib \
	mysql-client \
	postgresql-client \
        tar

ADD nginx.conf php-fpm.conf /
RUN mv /nginx.conf /etc/nginx/nginx.conf && \
    cat /php-fpm.conf >> /etc/php7/php-fpm.d/www.conf

WORKDIR /var/www

VOLUME /var/www

EXPOSE 80

CMD php-fpm7 && nginx -g 'daemon off;'
