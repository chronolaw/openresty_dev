#!/bin/sh

# Attention!
# You must modify your /etc/hosts
# Add below:
# 127.0.1.1     www.chrono.com
# 127.0.1.1     www.metroid.net
#
# Or else OpenResty will be blocked in resolving

openresty_path="/usr/local/openresty"
openresty="${openresty_path}/bin/openresty"
opts="-p `pwd`"

if [ $# -eq 0 ] ; then
    sudo $openresty $opts
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

sudo $openresty $opts

