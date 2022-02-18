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
        php8-common \
        php8-curl \
        php8-ctype \
        php8-dom \
        php8-fileinfo \
        php8-fpm \
        php8-gd \
        php8-iconv \
        php8-json \
        php8-openssl \
        php8-mbstring \
        php8-mysqli \
        php8-mysqlnd \
        php8-opcache \
        php8-pdo \
        php8-pdo_mysql \
        php8-pdo_pgsql \
        php8-pdo_sqlite \
        php8-pear \
        php8-phar \
        php8-pgsql \
        php8-session \
        php8-simplexml \
        php8-sqlite3 \
        php8-tokenizer \
        php8-xml \
        php8-xmlreader \
        php8-xmlwriter \
        php8-zip \
        php8-zlib \
        mysql-client \
        postgresql-client \
        tar \
    && \
    apk add php8-pecl-redis --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    && \
    rm -rf /var/cache/apk/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

ADD nginx.conf php-fpm.conf /
RUN mv /nginx.conf /etc/nginx/nginx.conf && \
    cat /php-fpm.conf >> /etc/php8/php-fpm.d/www.conf && \
    echo "log_errors_max_len = 1048576" >> /etc/php8/php.ini && \
    php8 -v

WORKDIR /var/www

EXPOSE 80

CMD php-fpm8 && nginx -g 'daemon off;'
