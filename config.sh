#!/bin/sh

build_date="${USER} build at `date '+%Y.%m.%d %H:%M'`"

no_modules="--without-http_fastcgi_module \
            --without-http_uwsgi_module \
            --without-http_scgi_module
           "

stream="--with-stream"

github="${HOME}/github"

addons="--add-module=${github}/stream-lua-nginx-module
       "

./configure     \
        --build="${build_date}" \
        ${no_modules}           \
        ${stream}               \
        ${addons}


