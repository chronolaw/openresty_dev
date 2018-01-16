-- Copyright (C) 2017-2018 by chrono

-- we should set content-length for keep alive

ngx.req.set_header("Accept", "Firefox")
ngx.req.set_header("Metroid", "Prime")

ngx.req.set_header("Metroid", nil)
ngx.req.clear_header("Accept")

local headers = ngx.req.get_headers()

local count = 0

ngx.say("req headers are : ")
for k, v in pairs(headers) do
    ngx.say("\t", k, " : ", v)
    count = count + 1
end

ngx.say("total ", count, " headers")

ngx.say(headers.host)
ngx.say(headers.user_agent)

ngx.say(headers['User-Agent'])
ngx.say(headers['Accept'])
