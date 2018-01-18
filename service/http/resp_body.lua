-- Copyright (C) 2017-2018 by chrono

ngx.header.content_length = nil

local data = {'mario','zelda','metroid'}

ngx.say(data)

for _,v in ipairs(data) do
    ngx.print(v)
    ngx.flush(true)
end
ngx.say('')
