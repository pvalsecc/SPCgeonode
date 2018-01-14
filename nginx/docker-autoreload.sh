#!/bin/sh

# This will watch the /spcgeonode-certbot-keys folder and run nginx -s reload whenever there are some changes.
# We use this to reload nginx config when certificates changed.

# inspired/copied from https://github.com/kubernetes/kubernetes/blob/master/examples/https-nginx/auto-reload-nginx.sh

while true
do
        inotifywait -e create -e modify -e delete -e move -r /spcgeonode-certbot-keys
        echo "Changes noticed in /spcgeonode-certbot-keys"
        # Test nginx configuration
        nginx -t
        # If it passes, we reload
        if [ $? -eq 0 ]
        then
                echo "Configuration valid, we reload..."
                nginx -s reload
        else
                echo "Configuration not valid, we do not reload."
        fi
done
