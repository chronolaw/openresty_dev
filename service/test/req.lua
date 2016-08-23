-- Copyright (C) 2016 by chrono

-- modify response headers
ngx.header["Host-Name"] = ngx.var.hostname

-- we should set content-length for keep alive

-- send headers must before say or print
ngx.send_headers()
assert(ngx.headers_sent)

-- send response body data
ngx.say("openresty test req params\n")

ngx.say("nginx : ", ngx.config.nginx_version)
ngx.say("openresty : ", ngx.config.ngx_lua_version)
ngx.say("jit : ", jit.os, ",", jit.arch, ",", jit.version)

ngx.say("")

local method = ngx.req.get_method()
ngx.say("method = ", method)

local uri = ngx.var.request_uri
ngx.say("uri = ", uri)

ngx.say("http = ", ngx.req.http_version())

ngx.say("")

local headers = ngx.req.get_headers()

local count = 0

ngx.say("req headers are : ")
for k, v in pairs(headers) do
    ngx.say("\t", k, " : ", v)
    count = count + 1
end

ngx.say("total ", count, " headers")

-- finish body data
ngx.eof()
