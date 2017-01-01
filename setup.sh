#!/bin/sh

echo "create directories for nginx ..."

#dirs="client_body_temp logs"
#$dirs="client_body_temp fastcgi_temp logs proxy_temp scgi_temp uwsgi_temp"
dirs="logs"

for name in $dirs
do
    if [ ! -d $name ] ; then
        mkdir $name
    fi
done

echo "setup ok"
