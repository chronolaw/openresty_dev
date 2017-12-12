#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

print[[string]]

local function f1(a)
    a = 'sliver'
    print("var is ", a)
end

f1{1,2,3}

local x = 'golden'
f1(x, 'heart')
assert(x == 'golden')

local function f2(a, b, c)
    print(a .. (b or '') .. (c or ''))
end

f2('Crazy', 'Diamond')

local function f3(a, b)
    return a+b, a*b
end

local x, y = f3(10, 20)
assert(x == 10+20 and y == 10*20)

print((f3(1,2)))
