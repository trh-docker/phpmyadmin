FROM quay.io/spivegin/php7:7.1

WORKDIR /opt/tlm/html 
ENV PHP_VERSION=7.1

RUN apt-get update &&\ 
    apt-get install -y bzip2 php${PHP_VERSION}-bz2 php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-imap php${PHP_VERSION}-curl php${PHP_VERSION}-opcache php${PHP_VERSION}-mysql && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 
ADD https://files.phpmyadmin.net/phpMyAdmin/4.8.5/phpMyAdmin-4.8.5-all-languages.zip /opt/tlm/html
# phpmyadmin-RELEASE_4_8_5
RUN unzip phpMyAdmin-4.8.5-all-languages.zip &&\
    rm phpMyAdmin-4.8.5-all-languages.zip &&\
    chown -R www-data:www-data . &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/phpMyAdmin/config.sample.inc.php /opt/tlm/html/phpMyAdmin-4.8.5-all-languages/config.inc.php
EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
