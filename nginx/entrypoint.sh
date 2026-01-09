#!/bin/sh
set -e

# Generate .htpasswd from Fly secrets
if [ -n "$BASIC_AUTH_PASSWORD_HASH" ]; then
    echo "philippkaiderat:$BASIC_AUTH_PASSWORD_HASH" > /etc/nginx/.htpasswd
    echo "Basic auth enabled"
else
    echo "Warning: BASIC_AUTH_PASSWORD_HASH not set, basic auth disabled"
fi

# Start nginx
exec nginx -g 'daemon off;'
