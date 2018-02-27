-- Copyright (C) 2018 by chrono

local function msgpack_uint_helper(c)
    local tags = {
        [0xcc] = 1,
        [0xcd] = 2,
        [0xce] = 4,
        }

    local x = string.byte(c)
    --ngx.log(ngx.ERR, "c = ", x)
    if x <= 0x7f then
        return 0
    else
        return tags[c] -- or nil
    end
end

local ok, mp = pcall(require, "resty.msgpack")
if not ok then
    ngx.log(ngx.ERR, "resty.msgpack has not been installed")
    return
end

local sock = assert(ngx.req.socket())

local c, err = sock:receive(1)
if not c or err then
    ngx.log(ngx.ERR, "recieve header from client failed: ", err)
    return
end

local remains = msgpack_uint_helper(c)
assert(remains)

local len
if remains > 0 then
    len = mp.unpack(c)
else
    local data, err = sock:receive(remains)
    if not data or err then
        ngx.log(ngx.ERR, "recieve header from client failed: ", err)
        return
    end

    len = mp.unpack(c .. data)
end

--local len = tonumber(data)
--ngx.log(ngx.ERR, "header is: ", len)

local data, err = sock:receive(len)
if not data or err then
    ngx.log(ngx.ERR, "recieve body from client failed: ", err)
    return
end

local msg = mp.unpack(data)
--ngx.log(ngx.ERR, "msg = ", msg.str)

local msg = string.rep(msg.str, msg.num)

local body = mp.pack(msg)
local header = mp.pack(#body)
--local header = string.format("%04d", #body)

local _, err = sock:send(header .. body)
if err then
    ngx.say("failed to send data to client: ", err)
    return
end

--sock:shutdown("send")

