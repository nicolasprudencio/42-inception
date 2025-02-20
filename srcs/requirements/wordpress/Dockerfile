FROM debian:oldstable

WORKDIR /var/www/html/

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	php7.4 \
	php-fpm \
	php7.4-mysql \
	mariadb-client \
	wget

RUN mkdir -p /run/php

RUN chown -R www-data:www-data /var/www/html && \
	chmod 755 /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

CMD ["/tmp/script.sh"]