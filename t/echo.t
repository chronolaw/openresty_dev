# Copyright (c) 2018 by chrono
#
# sudo cpan Test::Nginx
# export PATH=/usr/local/openresty/nginx/sbin:$PATH
# prove t/var.t

use Test::Nginx::Socket 'no_plan';

no_root_location();
run_tests();

__DATA__

=== TEST 1 : echo footer

--- config
location / {
    proxy_set_header Host $host;
    proxy_pass http://127.0.0.1:80;
}

--- request
GET /echo

--- response_headers_like
x-name: chrono
x-value: trigger

--- response_body_like
ocarina of time

