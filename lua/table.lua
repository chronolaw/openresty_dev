#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local a = {3, 5, 7}
local d = {one=1,two=2}
local t = {red=9, [3]=3, ['a'] = {}}

assert(a[1] == 3 and a[2] == 5)
assert(d['one'] == 1)
assert(t['red'] == 9 and t[3] == 3)

a[1] = 100

d['three'] = 3
assert(d['three'] == 3)

local x = {}

x['name'] = 'samus'
x.job = 'hunter'

print(x.name, ' : ', x['job'])

x.mission = function(dst)
    print('fly to ', dst)
end

x.mission('zebes')

assert(#a == 3)
for i=1, #a do
    print(a[i], ', ')
end

x['key'] = 1
assert(#x == 0)

for i,v in ipairs(a) do
    print(a[i], ', ')
end

for k,v in pairs(x) do
    print(k, ' => ', v)
end

local function f(v)
    v.name = v.name .. ' aran'
end

f(x)
print(x.name)

