#!/bin/sh

build_date="${USER} build at `date '+%Y.%m.%d %H:%M'`"

no_modules="--without-http_fastcgi_module \
            --without-http_uwsgi_module \
            --without-http_scgi_module
           "

./configure                     \
        --build="${build_date}" \
        --with-http_v2_module   \
        ${no_modules}


