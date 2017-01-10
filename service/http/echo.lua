-- Copyright (C) 2017 by chrono

local echo_string = "hello nginx\n"

local method = ngx.req.get_method()

if method ~= "GET" then
    ngx.log(ngx.INFO, "only support get method")
    return
end

ngx.req.discard_body()

local args = ngx.var.args or ""

local len = #echo_string
local str = echo_string

if #args > 0 then
    len = #args + 1 + len
    str = args .. "," .. str
end

ngx.header.content_length = len
ngx.status = 200

ngx.send_headers()

ngx.print(str)
