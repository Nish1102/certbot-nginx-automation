#!/bin/bash

# Renew certificates
/usr/local/bin/certbot renew --quiet --no-self-upgrade

# Reload Nginx to apply the renewed certificates
systemctl reload nginx

# Log the renewal attempt
echo "$(date): Certificate renewal attempted." >> /var/log/certbot-renew.log
