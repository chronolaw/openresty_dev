#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local data, err
local a, b = 1, 'lua'
local x, y = a, b, 'not_used'
local m, n = "only this"

do
    local x = 10
    print("x = ", x)
end

for i=1,5 do
    print("for : ", i)
end
assert(not i)

for i=1,10,2 do
    print("for : ", i)
end
assert(not i)
