-- Copyright (C) 2018 by chrono

local sock, err = ngx.req.socket()
assert(sock)

local len = tonumber(ngx.var.http_content_length)
local data = sock:receive(len)

--ngx.say(len, data)

--ngx.req.read_body()
--local data = ngx.req.get_body_data()

ngx.header.content_length = len --ngx.var.http_content_length
ngx.send_headers()
ngx.flush(true)

--ngx.say(data)
local sock, err = ngx.req.socket(true)
sock:send(data)
