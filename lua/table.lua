#!/usr/local/openresty/bin/resty

local a = {3, 5, 7}

assert(a[1] == 3 and a[2] == 5)

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

for i,v in ipairs(a) do
    print(a[i], ', ')
end

for k,v in pairs(x) do
    print(k, ' => ', v)
end


