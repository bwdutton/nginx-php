A generic nginx and php-fpm container to host PHP web sites.

Create an html directory inside of the directory you want to mount, e.g.:

mkdir -p containers/myapp/html
echo '<?php echo 'hello'; ?>' > containers/docuwiki/html/index.php

Belwo is a sample docker compose configuration. I recommend running traefik if you want the app to run under SSL or host multiple apps on the same server.

version: '3.5'
services:
  myapp:
    image: bwdutton/nginx-php
    volumes:
      - ./containers/myapp:/var/www
    ports:
      - "80:80"
