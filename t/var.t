# Copyright (c) 2018 by chrono
#
# sudo cpan Test::Nginx
# export PATH=/usr/local/openresty/nginx/sbin:$PATH
# prove t/var.t

use Test::Nginx::Socket 'no_plan';

run_tests();

__DATA__

=== TEST 1 : var.request_method

--- config
location = /var {
    content_by_lua_block {
        ngx.say(ngx.var.request_method)
    }
}

--- request
GET /var

--- response_body
GET

