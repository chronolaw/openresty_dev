# Copyright (c) 2018 by chrono
#
# sudo cpan Test::Nginx
# export PATH=/usr/local/openresty/nginx/sbin:$PATH
# prove t/var.t

#use Test::Nginx::Socket 'no_plan';
use Test::Nginx::Socket;

repeat_each(2);
plan tests => repeat_each() * (blocks() + 1);

no_root_location();
run_tests();

__DATA__

=== TEST 1 : http2 degrade

--- config
location / {
    #proxy_ssl_server_name on;
    proxy_set_header Host $host;
    proxy_pass https://127.0.0.1:85;
}

--- request
GET /

--- response_body
hello 
scheme: https

=== TEST 2 : http2

--- config
location / {
    #proxy_ssl_server_name on;
    proxy_set_header Host $host;
    proxy_pass https://127.0.0.1:85;
}

--- request
GET /

--- response_body
hello h2
scheme: https

--- SKIP

