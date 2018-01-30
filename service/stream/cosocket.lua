-- Copyright (C) 2018 by chrono

-- curl 127.1:81/cosocket

local ok, mp = pcall(require, "resty.msgpack")
if not ok then
    ngx.log(ngx.ERR, "resty.msgpack has not been installed")
    return
end

local sock = assert(ngx.req.socket())

local data, err = sock:receive(4)
if not data or err then
    ngx.log(ngx.ERR, "recieve header from client failed: ", err)
    return
end

local len = tonumber(data)
ngx.log(ngx.ERR, "header is: ", len)

local data, err = sock:receive(len)
if not data or err then
    ngx.log(ngx.ERR, "recieve body from client failed: ", err)
    return
end

local msg = mp.unpack(data)
--ngx.log(ngx.ERR, "msg = ", msg.str)

local msg = string.rep(msg.str, msg.num)

local body = mp.pack(msg)
local header = string.format("%04d", #body)

local _, err = sock:send(header .. body)
if err then
    ngx.say("failed to send data to client: ", err)
    return
end

