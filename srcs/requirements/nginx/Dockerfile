#base image
FROM debian:bullseye

# Add build argument for domain name
ARG DOMAIN_NAME
ENV DOMAIN_NAME=${DOMAIN_NAME}

#Updates the package list and installs Nginx and OpenSSL.
RUN apt-get update && apt-get install -y nginx openssl

#Create SSL Directory and Generate SSL Certificate
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/CN=${DOMAIN_NAME}"

#Copy Nginx Configuration and HTML File
COPY ./conf/nginx.conf /etc/nginx/conf.d
COPY ./tools/index.html /usr/share/nginx/html/
COPY ./tools/init.sh /tmp/

RUN chmod +x /tmp/init.sh

EXPOSE 443

CMD [ "/tmp/init.sh" ]