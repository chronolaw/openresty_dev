#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

print(0xff, ' ', 0xff00)

print(1 + 1, ",", 5 - 3)
print(2 * 4, ",", 1 / 3)
print(5 % 2, ",", 3 ^ 3)

count = 10
count = count + 1       -- equalient to ++count
assert(count == 11)

print(5 + '10')
--print(5 + 'xxx')

print(3.14 > 2.718)
print(1/3 == 2/6)
print('10' ~= 10)
print(tonumber('10') == 10)

print(0 and 'abc')
print(x or 100)
print(not x)

local x = count or 100
local y = a and b or c

assert(x == 100)
assert(not y)

print('hello'..' '..'world')

print(#'openresty')
print(#{1, 2, 3})

x = nil
print(1 + (x or 2))
print("msg is ".. (x or "-"))
