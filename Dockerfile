FROM alpine:3

RUN set -xe && \
    apk add gnu-libiconv --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    && \
    apk -U upgrade \
    && \
    apk add --update \
        ca-certificates \
        composer \
        gnu-libiconv \
        gzip \
        nginx \
        openssl \
        php7-common \
        php7-curl \
        php7-ctype \
        php7-dom \
        php7-fileinfo \
        php7-fpm \
        php7-gd \
        php7-iconv \
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
        php7-simplexml \
        php7-sqlite3 \
        php7-tokenizer \
        php7-xml \
        php7-xmlwriter \
        php7-zip \
        php7-zlib \
        mysql-client \
        postgresql-client \
        tar \
    && \
    apk add php7-pecl-redis --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    && \
    rm -rf /var/cache/apk/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

ADD nginx.conf php-fpm.conf /
RUN mv /nginx.conf /etc/nginx/nginx.conf && \
    cat /php-fpm.conf >> /etc/php7/php-fpm.d/www.conf && \
    echo "log_errors_max_len = 1048576" >> /etc/php7/php.ini

WORKDIR /var/www

EXPOSE 80

CMD php-fpm7 && nginx -g 'daemon off;'
