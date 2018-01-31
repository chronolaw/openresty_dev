-- Copyright (C) 2018 by chrono

-- curl 127.1:81/capture

local function msgpack_uint_helper(c)
    local tags = {
        [0xcc] = 1,
        [0xcd] = 2,
        [0xce] = 4,
        }

    local x = string.byte(c)
    if x <= 0x7f then
        return 0
    else
        return tags[c] -- or nil
    end
end

local ok, mp = pcall(require, "resty.msgpack")
if not ok then
    ngx.say("resty.msgpack has not been installed")
    return
end

local sock = ngx.socket.tcp()
sock:settimeout(1000)

local ok, err = sock:connect("127.0.0.1", 900)
if not ok then
    ngx.say("failed to connect to backend: ", err)
    return
end

local msg = {str = "hello", num = 3}

local body = mp.pack(msg)
local header = mp.pack(#body)

--local header = string.format("%04d", #body)

--ngx.log(ngx.ERR, "header len is: ", #header)

local _, err = sock:send(header .. body)
if err then
    ngx.say("failed to send data to backend: ", err)
    return
end

local c, err = sock:receive(1)
if not c or err then
    ngx.log(ngx.ERR, "recieve header from backend failed: ", err)
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

local data, err = sock:receive(len)
if not data or err then
    ngx.log(ngx.ERR, "recieve body from backend failed: ", err)
    return
end

local msg = mp.unpack(data)
ngx.say("receive from backend: ", msg)

