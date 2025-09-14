FROM debian:bookworm

# Copiar setup.sh
COPY ./conf/setup.sh /tmp

# Instalar PHP y herramientas necesarias
RUN apt-get update && apt -y install curl wget netcat-traditional tar
RUN apt install -y php php-fpm php-mysql php-gd php-xml php-curl
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    php \
    php-fpm \
    php-mysql \
    php-gd \
    php-xml \
    php-curl \
    netcat-traditional \
    tar && \
    rm -rf /var/lib/apt/lists/*
# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv -f wp-cli.phar /usr/local/bin/wp

# Permisos
RUN chmod +x /tmp/setup.sh

# Configuracion
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
RUN sed -i 's|^pid = /run/php/php8.2-fpm.pid$|pid = /var/run/php-fpm8.2.pid|' /etc/php/8.2/fpm/php-fpm.conf

EXPOSE 9000

CMD [ "sh", "-c", "/tmp/setup.sh && php-fpm8.2 -F" ]
