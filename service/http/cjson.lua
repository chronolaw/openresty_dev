-- Copyright (C) 2016 by chrono

-- safe decode
local cjson = require "cjson.safe"

ngx.say("test cjson")

local str = cjson.encode({name='jojo', cat = 'comic'})

ngx.say(str)

local obj = cjson.decode(str)

assert(obj.name == 'jojo')
assert(obj.cat == 'comic')

obj = cjson.decode([[{"error":format"}]])
assert(not obj)

ngx.exit(200)
