# Copyright (c) 2018 by chrono
#
# sudo cpan Test::Nginx
# export PATH=/usr/local/openresty/nginx/sbin:$PATH
# prove t/var.t

#use Test::Nginx::Socket 'no_plan';
use Test::Nginx::Socket;

repeat_each(2);
plan tests => repeat_each() * (blocks() + 3);

no_root_location();
run_tests();

__DATA__

=== TEST 1 : https sni:www.chrono.com

--- config
location / {
    proxy_ssl_server_name on;
    proxy_set_header Host $host;
    proxy_pass https://www.chrono.com:84;
}

--- request
GET /

--- response_body
hello openresty with https

=== TEST 2 : https sni:www.metroid.net

--- config
location / {
    proxy_ssl_server_name on;
    proxy_set_header Host $host;
    proxy_pass https://www.chrono.com:84;
}

--- request
GET /

--- response_body
hello openresty with https

=== TEST 3 : hello https

--- config
location / {
    proxy_ssl_server_name on;
    proxy_set_header Host $host;
    proxy_pass https://www.chrono.com:84;
}

--- request
GET /hello

--- response_body_like
scheme: https

=== TEST 4 : https no sni

--- config
location / {
    proxy_ssl_server_name on;
    proxy_set_header Host $host;
    proxy_pass https://127.0.0.1:84;
}

--- request
GET /

--- error_code: 502

