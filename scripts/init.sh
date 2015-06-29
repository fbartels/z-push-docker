#!/bin/bash
set -e

if [ ! -e /etc/zarafa-init-completed ]; then
	echo "This image has been started for the first time."
	# replace url of Zarafa host
	sed -i -e 's,file:///var/run/zarafa,'${ZARAFA_HOST}',g' /usr/share/z-push/backend/zarafa/config.php
	echo
	echo "Initial Setup completed"
	touch /etc/zarafa-init-completed
fi

services="cron apache2"
for s in $services; do
	echo "starting $s"
	service $s start
done

# exec CMD
echo "Starting $@ .."
exec "$@"
