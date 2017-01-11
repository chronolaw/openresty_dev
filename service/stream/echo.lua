-- Copyright (C) 2017 by chrono

local ffi = require "ffi"
local band, brshift = bit.band, bit.rshift
local tochar = string.char

local sock = assert(ngx.req.socket())

-- 3 seconds
sock:settimeout(3000)

local data, err = sock:receive(4)   -- 4bytes buffer

if not data or err then
    ngx.log(ngx.ERR, "received error : ", err)
    ngx.exit(ngx.ERROR)
end

local timestamp = tostring(ngx.time())
local len = #data + #timestamp

local header = tochar(brshift(band(len, 0xff00),8)) ..
               tochar(band(len, 0xff))

-- message header
local ok, err = sock:send(header)
if not ok or err then
    ngx.log(ngx.ERR, "send header error : ", err)
    ngx.exit(ngx.ERROR)
end

-- message body
ok, err = sock:send(data .. timestamp)
if not ok or err then
    ngx.log(ngx.ERR, "send body error : ", err)
    ngx.exit(ngx.ERROR)
end

ngx.exit(ngx.OK)
