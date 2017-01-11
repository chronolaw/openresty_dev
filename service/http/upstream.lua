-- Copyright (C) 2017 by chrono

local ffi = require "ffi"
local band, blshift = bit.band, bit.lshift
local byte = string.byte

-- $backend_addr, $backend_port
-- we also could use ngx_http_lua_upstream
--local backend_addr = ngx.var.backend_addr or "127.0.0.1"
--local backend_port = tonumber(ngx.var.backend_port or 2017)
local backend_addr = "127.0.0.1"
local backend_port = 2017

local args = ngx.var.args
args = args and #args > 0 and args or "xxxx"

local sock = ngx.socket.tcp()

local ok, err = sock:connect(backend_addr, backend_port)

if not ok then
    ngx.say("failed to connect : ", err)
    return
end

local bytes, err = sock:send(args)

if err then
    ngx.say("failed to send : ", err)
    return
end

local data, err = sock:receive(2)

if not data or err then
    ngx.say("failed to receive : ", err)
    return
end

local a,b = byte(data, 1, 2)
local len = blshift(a, 8) + b

data, err = sock:receive(len)

if not data or err then
    ngx.say("failed to receive : ", err)
    return
end

ngx.say("received : ", data)

