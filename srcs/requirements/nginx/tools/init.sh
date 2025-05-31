#!/bin/bash

# Replace environment variables in nginx config and html
sed -i "s/\${DOMAIN_NAME}/${DOMAIN_NAME}/g" /etc/nginx/conf.d/nginx.conf
sed -i "s/\${INCEPTION_MASTER}/${INCEPTION_MASTER}/g" /usr/share/nginx/html/index.html

# Start nginx
nginx -g "daemon off;"