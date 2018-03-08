-- Copyright (C) 2018 by chrono

-- curl 127.1:81/http

local http = require "resty.http"

local httpc = http:new()
httpc:set_timeout(1000)

--local ok, err = httpc:connect('127.0.0.1', 80)
--if not ok then
--    ngx.say("failed to connect : ", err)
--    httpc:close()
--    return
--end

local res, err = httpc:request_uri(
            'http://127.0.0.1',
            {path = '/echo',
             query = {name = 'chrono'}}
            )
if not res then
    ngx.say("failed to request : ", err)
    return
end

for k,v in pairs(res.headers) do
    ngx.say(k, ' => ', v)
end

ngx.say(res.body)

local res, err = httpc:request_uri(
            'http://nginx.org',
            {path = '/en/download.html',
             headers = {name = 'chrono'}}
            )
if not res then
    ngx.say("failed to request : ", err)
    return
end

ngx.say("status : ", res.status)
ngx.say("body len : ", #res.body)

ngx.say("http ok")

