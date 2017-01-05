#!/usr/local/openresty/bin/resty

local cjson = require "cjson"

local str = cjson.encode({a=1,b=2})
print(str)
