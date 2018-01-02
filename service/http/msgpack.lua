-- Copyright (C) 2017 by chrono

-- local mp = require "resty.msgpack"
local ok, mp = pcall(require, "resty.msgpack")
if not ok then
    ngx.say("resty.msgpack has not been installed")
    return
end

local obj = {a=1, b=2, x="star"}

local enc = mp.pack(obj)
ngx.say("encode len = ", #enc)

local dec = mp.unpack(enc)

assert(dec.a == 1 and dec.b == 2)
assert(dec.x == obj.x)

local a = 'hello'
local b = {1,2,3}
local c = 2.718

local data = mp.pack(a)..mp.pack(b)..mp.pack(c)

for i, v in mp.unpacker(data) do
    ngx.say("offset ", i, " is ", v)
end

ngx.say('do not use ipairs')

local iter = mp.unpacker(data)
while iter do
    local i, v = iter()
    if not v then
        break
    end

    ngx.say("offset ", i, " is ", v)
end
