#!/bin/sh

ngx_path="/usr/local/openresty/nginx"
ngx="${ngx_path}/sbin/nginx"
opts="-p `pwd`"

if [ $# -eq 0 ] ; then
    sudo $ngx $opts
    exit 0
fi

if [ $# -gt 1 ] ; then
    echo "too many args"
    exit 1
fi

if [ $1 != "stop" -a $1 != "reload" ] ; then
    echo "format : $0 [stop|reload]"
    exit 1
fi

opts="$opts -s $1"

sudo $ngx $opts

