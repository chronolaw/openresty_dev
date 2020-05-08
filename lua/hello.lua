#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty

-- emulate lua 5.1 print
--local print = ngx.say

print("hello lua")

local n = #arg
print("args count = ", n)
for i = 1,n do
    print("arg ", i , ": ", arg[i])
end

local str_time = '2019-2-20T08:30:00+0000'
local m = ngx.re.match(str_time,[[(\d+)-(\d+)-(\d+)(?:\s+|T)(\d+):(\d+):(\d+)]])
print(m[0], '=>', m[1], m[4])

local str = "v3"--"neir:automata"
local reg = [==[v[12]]==]--[[^(\w+):(\w+)$]]

local m = ngx.re.match(str, reg, "jo")
print(m and m[0] or "not")

--print (package.path)

--local cjson = require "cjson.safe"
--cjson.encode_number_precision(16)
--print(cjson.encode({a=12345678901234567890}))

--local x = 12345678901234567890
--print(tostring(x))
local x = '1161928703861592055'
print(tonumber(x))
