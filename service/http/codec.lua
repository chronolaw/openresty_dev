-- Copyright (C) 2017 by chrono

local clock = require "utils.clock"

local c = clock:new()

local str = "1234567890"

ngx.say("str : ", str)

ngx.say("md5 : ", ngx.md5(str))

ngx.say("crc : ", ngx.crc32_short(str))

ngx.say("base64 : ", ngx.encode_base64(str))

local resty_str = require "resty.string"

ngx.say("hex : ", resty_str.to_hex(str))

local resty_rand = require "resty.random"

local hex_str = resty_rand.bytes(10)
ngx.say("hex : ", resty_str.to_hex(hex_str))

str = "% /"

ngx.say("str : ", str)

local escape_str = ngx.escape_uri(str)

ngx.say("escape : ", escape_str)
ngx.say("unescape : ", ngx.unescape_uri(escape_str))

ngx.say("time used = ", c:elapsed(), "ms")
