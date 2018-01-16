-- Copyright (C) 2017-2018 by chrono

-- curl '127.1:80/req?a=1&b=2'
local vars = {"request", "request_uri", "uri", "args"}

for _,v in ipairs(vars) do
    ngx.say("uri : ", ngx.var[v])
end

ngx.req.set_uri("/new_req_uri")
ngx.say(ngx.var.uri)

