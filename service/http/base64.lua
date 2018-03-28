-- Copyright (C) 2017 by chrono

local str = "1234"
local enc = ngx.encode_base64(str)
local dec = ngx.decode_base64(enc)

ngx.say(enc)
ngx.say(dec)

local enc = ngx.encode_base64(str, true)
ngx.say(enc)

local ok, b64 = pcall(require, "ngx.base64")
if not ok then
    ngx.say('no base64url')
    return
end

local str = "=>?@"
local enc_std = ngx.encode_base64(str)
local enc_url = b64.encode_base64url(str)
local dec = b64.decode_base64url(enc_url)

ngx.say(enc_std)
ngx.say(enc_url)
assert(dec == str)
