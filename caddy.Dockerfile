FROM quay.io/spivegin/php7:7.1

WORKDIR /opt/tlm/html 
ENV PHP_VERSION=7.1

RUN apt-get update &&\ 
    apt-get install -y php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-imap php${PHP_VERSION}-curl php${PHP_VERSION}-opcache php${PHP_VERSION}-mysql && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 
ADD https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_8_5.zip /opt/tlm/html
# phpmyadmin-RELEASE_4_8_5
RUN unzip RELEASE_4_8_5.zip &&\
    chown -R www-data:www-data . &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD files/Caddy/Caddyfile /opt/caddy/
EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
