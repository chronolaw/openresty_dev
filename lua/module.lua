#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local cjson = require "cjson"

local str = cjson.encode({a=1,b=2})
print(str)
