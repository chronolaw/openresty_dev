#!/bin/sh

build_date="${USER} build at `date '+%Y.%m.%d %H:%M'`"

modules="--with-stream"

no_modules="--without-http_fastcgi_module \
            --without-http_uwsgi_module \
            --without-http_scgi_module
           "

addons=""

./configure     \
        --build="${build_date}" \
        ${no_modules}


