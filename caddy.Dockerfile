FROM quay.io/spivegin/php7

WORKDIR /opt/tlm/html 

RUN apt-get update &&\ 
    apt-get install -y php7.0-zip php7.0-bcmath php7.0-imap php7.0-curl php7.0-opcache php7.0-mysql && \
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
