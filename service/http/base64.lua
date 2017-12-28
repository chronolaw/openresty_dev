-- Copyright (C) 2017 by chrono

local str = "1234"
local enc = ngx.encode_base64(str)
local dec = ngx.decode_base64(enc)

ngx.say(enc)
ngx.say(dec)

local enc = ngx.encode_base64(str, true)
ngx.say(enc)
