-- Copyright (C) 2017 by chrono

local method = ngx.req.get_method()

if method ~= "GET" then
    ngx.log(ngx.INFO, "only support get method")
    return
end

ngx.req.discard_body()

local str = ngx.var.echo_string or "hello nginx"
local args = ngx.var.args or ""

if #args > 0 then
    ngx.print(args, ",")
end

ngx.say(str)
