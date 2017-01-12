-- Copyright (C) 2017 by chrono

local count = 5;

local t = {}
for i=0x20,(0x7f-1) do
    t[#t+1] = string.char(i)
end

local str = table.concat(t)
local len = #str;

for i=1,count do
    if i > len then
        i = 1
    end
    ngx.say(string.sub(str, i), string.sub(str,1,i-1))
    ngx.sleep(0.2)
end

