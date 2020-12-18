#!/usr/local/openresty/bin/resty

-- Copyright (C) 2020 by chrono

-- resty redis.lua

local cjson = require "cjson.safe"
local redis = require "resty.redis"

local rds = redis:new()

rds:set_timeout(1000)   -- 1 sec

local ok,err
local res

ok, err = rds:connect("127.0.0.1",6379)
if not ok then
    ngx.say("failed to connect : ", err)
    rds:close()
    return
end
--assert(ok)

-- test auth
--ok, err = rds:auth('12345')
--ngx.say('auth = ', ok, ' err = ', err)

local topic = 'mq'

res, err = rds:xlen(topic)

local mq_len = tonumber(res)
print(mq_len)

if mq_len == 0 then
    ok, err = rds:xadd(topic, '*', "name", "111")
    assert(ok)
end

res, err = rds:xread('count', '2', 'streams', topic, 0)
if err then
    print('xread err: ', err)
end
print(cjson.encode(res))

assert(res[1][1] == topic)

local values = res[1][2]

for i,v in ipairs(values) do
    print('msg id = ', v[1])
    print('msg key = ', v[2][1])
    print('msg value = ', v[2][2])
end

ngx.say('redis ok')
