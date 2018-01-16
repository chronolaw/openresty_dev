-- Copyright (C) 2017 by chrono

local args = {n=1, v=100, title='odyssey'}
local enc = ngx.encode_args(args)
local dec = ngx.decode_args(enc)

ngx.say(enc)
