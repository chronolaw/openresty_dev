-- Copyright (C) 2017-2018 by chrono

-- curl 127.1:83/timer

local function once_task(premuture, uri)
    if premuture then
        ngx.log(ngx.WARN, uri, ": task abort")
        return
    end

    local http = require "resty.http"
    local httpc = http:new()

    local res, err = httpc:request_uri('http://127.0.0.1/hello')

    ngx.log(ngx.ERR, uri, ": task success")
end

local ok, err = ngx.timer.at(0.1, once_task, ngx.var.uri)
if not ok then
    ngx.say("timer failed: ", err)
    return
end

local function cycle_task(premuture, name)
    if premuture then
        return
    end

    ngx.shared[name]:incr("count", 1, 0)
end

--[[
local ok, err = ngx.timer.every(60, cycle_task, "shmem")
if not ok then
    ngx.say("timer failed: ", err)
    return
end
--]]

ngx.say('hello openresty timer')


