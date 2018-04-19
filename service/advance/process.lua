-- Copyright (C) 2017-2018 by chrono

local process = require "ngx.process"

local str = process.type()
assert(str == "worker")
ngx.say("type is ", str)

ngx.say("count = ", ngx.worker.count())
ngx.say("pid = ", ngx.worker.pid())
ngx.say("id = ", ngx.worker.id())
ngx.say("status = ", ngx.worker.exiting())

-- curl 127.1:83/process?reload=1
local arg = ngx.var.arg_reload
if tonumber(arg) == 1 then
    process.signal_graceful_exit()
end

ngx.say('hello openresty process')
