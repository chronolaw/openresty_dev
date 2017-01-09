#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local str = 'hello lua'
print(string.sub(str, 1, 4))
print(string.sub(str, 7))
print(string.sub(str, 5, -1))

local a, b = string.byte(str, 1, 2)
print(a, ", ", b)

local a = {'openresty', 'lua'}
print(table.concat(a, '+'))

a[#a + 1] = 'nginx'
assert(#a == 3)

print(debug.traceback())

------
local str_sub = string.sub
local concat = table.concat

print(str_sub(str, 1, 4))
print(concat(a, '+'))

