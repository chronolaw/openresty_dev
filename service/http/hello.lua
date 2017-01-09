-- Copyright (C) 2017 by chrono

--local data = "hello"
--ngx.print(data)

--ngx.header["Content-length"] = #data
--ngx.header.content_length = #data

ngx.log(ngx.INFO, "hello openresty")
ngx.log(ngx.WARN, "warning is ", "some messgae")

local print = ngx.say

--print(ngx.time())
--print(ngx.now())
--print(ngx.today())

local secs = ngx.time()
local msecs = ngx.now()

assert(msecs - secs < 1)

print(ngx.http_time(secs))

print(ngx.var.uri)
print(ngx.var['http_host'])

if #ngx.var.is_args > 0 then
    print(ngx.var.args)
end

ngx.say('hello openresty')
--ngx.exit(200)
