-- Copyright (C) 2017 by chrono

local uri = "a + b = c #!"
local enc = ngx.escape_uri(uri)
local dec = ngx.unescape_uri(enc)

ngx.say(enc)
ngx.say(dec)
