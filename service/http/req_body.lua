-- Copyright (C) 2017-2018 by chrono

-- curl 127.1/req_body -d 'xxxx'

ngx.req.read_body()

local data = ngx.req.get_body_data()

if data then
    ngx.say("body: ", data)
else
    local name = ngx.req.get_body_file()
    local f = io.open(name, "r")
    data = f:read("*a")
    f:close()
end

ngx.req.set_body_data('yyyy')

local data = ngx.req.get_body_data()
ngx.say("body: ", data)

ngx.req.set_body_file("/tmp/map.list")
local data = ngx.req.get_body_data()
ngx.say("body: ", data or "-")

ngx.req.init_body()
ngx.req.append_body('aaa')
ngx.req.append_body('bbb')
ngx.req.finish_body()

local data = ngx.req.get_body_data()
ngx.say("body: ", data)

--[[
    local f = io.open("/tmp/map.list", "r")
    data = f:read("*a")
    f:close()
    ngx.say(data or "-")
--]]
