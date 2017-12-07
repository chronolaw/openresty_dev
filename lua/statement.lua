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

-- if-else
local x = nil
if x then
    print("x is not nil")
else
    print("x is nil")
end

-- while
local x = 3
while x > 0 do
    print("while")
    x = x - 1
end

-- repeat-until
local x = 3
repeat
    print("repeat-until")
    x = x - 1
until x<=0

-- for
for i=1,5 do
    print("for : ", i)
end
assert(not i)

for i=1,10,2 do
    print("for : ", i)
end
assert(not i)

-- break
for i=10,1,-1 do
    if i < 7 then
        print("countdown ok")
        break
    end
end
