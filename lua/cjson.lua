#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

-- safe decode
local cjson = require "cjson.safe"

print("test cjson")

local str = cjson.encode({name='jojo', cat = 'comic'})

print(str)

local obj = cjson.decode(str)

assert(obj.name == 'jojo')
assert(obj.cat == 'comic')

obj = cjson.decode([[{"error":format"}]])
assert(not obj)
