-- Copyright (C) 2017 by chrono

-- safe decode
local cjson = require "cjson.safe"

local str = cjson.encode({name='jojo', cat = 'comic'})

ngx.say(str)

local obj = cjson.decode(str)

assert(obj.name == 'jojo')
assert(obj.cat == 'comic')

obj = cjson.decode([[{"wrong":format"}]])
assert(not obj)

str = cjson.encode({1,2,3,4})
ngx.say(str)

cjson.encode_empty_table_as_object(false)
str = cjson.encode({})
ngx.say(str)

cjson.encode_empty_table_as_object(true)
str = cjson.encode({a={},b=cjson.empty_array})
ngx.say(str)

cjson.encode_number_precision(5)
str = cjson.encode({x=math.pi})
ngx.say(str)
