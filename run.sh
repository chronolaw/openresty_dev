#!/bin/sh

# Attention!
# You must modify your /etc/hosts
# Add below:
# 127.0.0.1     www.chrono.com
# 127.0.0.1     www.metroid.net
#
# Or else OpenResty will be blocked in resolving

flag=`grep 'www.chrono.com' /etc/hosts |wc -l`
if [ $flag = "0" ]; then
    echo "You must modify your /etc/hosts"
    echo "Or else OpenResty will be blocked in resolving"
    exit 1
fi

# openresty needs ./logs
if [ ! -d "logs" ]; then
    mkdir logs
fi

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

