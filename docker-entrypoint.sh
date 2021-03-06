#!/bin/bash

set -e

NGINX_TEMPLATE=/etc/nginx/nginx.conf.template
NGINX_CONF=/etc/nginx/nginx.conf 
ENV_OK=0

if [ -n "${YOUTUBE_KEY}" ]; then
	echo "Youtube activate."
	sed -i 's|#youtube|push '"$YOUTUBE_URL"'${YOUTUBE_KEY};|g' $NGINX_TEMPLATE
	ENV_OK=1
else
	sed -i 's|#youtube| |g' $NGINX_TEMPLATE
fi

if [ -n "${TELEGRAM_KEY}" ]; then
	echo "Telegram activate."
	sed -i 's|#telegram|push '"$TELEGRAM_URL"'${TELEGRAM_KEY};|g' $NGINX_TEMPLATE
	ENV_OK=1
else 
	sed -i 's|#telegram| |g' $NGINX_TEMPLATE
fi

if [ -n "${FACEBOOK_KEY}" ]; then
	echo "Facebook activate."
	sed -i 's|#facebook|push '"$FACEBOOK_URL"'${FACEBOOK_KEY};|g' $NGINX_TEMPLATE
	ENV_OK=1
else 
	sed -i 's|#facebook| |g' $NGINX_TEMPLATE
fi

if [ -n "${INSTAGRAM_KEY}" ]; then
	echo "Instagram activate."
	sed -i 's|#instagram|push '"$INSTAGRAM_URL"'${INSTAGRAM_KEY};|g' $NGINX_TEMPLATE
	ENV_OK=1
else 
	sed -i 's|#instagram| |g' $NGINX_TEMPLATE
fi

if [ $ENV_OK -eq 1 ]; then
    envsubst < $NGINX_TEMPLATE > $NGINX_CONF
else 
	echo "Start local server."
fi

if [ -n "${DEBUG}" ]; then 
	echo $NGINX_CONF
	cat $NGINX_CONF
fi

stunnel4

exec "$@"
