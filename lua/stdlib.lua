#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local str = 'Hello'
print(string.upper(str))
print(string.lower(str))

local str = 'hello lua'
print(string.sub(str, 1, 4))
print(string.sub(str, 7))
print(string.sub(str, 5, -1))

local a, b = string.byte(str, 1, 2)
print(a, ", ", b)

print(string.char(a, b))

str = string.format("%04d, %f, %s", 253, 3.14, 'lua')
print(str)


----------------------

local a = {1,2,3}
table.remove(a, 2)
assert(a[1] == 1 and a[2] == 3)

local a = {'openresty', 'lua'}
print(table.concat(a, '+'))

a[#a + 1] = 'nginx'
assert(#a == 3)

------------

math.randomseed(1.414)
for i=1,4 do
    print(math.random(), ',' , math.random(100))
end

-----------------

local f = io.open("./hello.lua", "r")
print(f:read("*line"))
print(f:read(20))
f:close()

local f = io.popen("ps -ef|grep nginx|wc -l")
print(f:read())
f:close()

-----------------

print(debug.traceback())

------
local str_sub = string.sub
local concat = table.concat

print(str_sub(str, 1, 4))
print(concat(a, '+'))

