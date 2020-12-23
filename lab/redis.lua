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
local group = 'test_group'
local consumer = 'test_consumer'

res, err = rds:xlen(topic)

local mq_len = tonumber(res)
print(mq_len)

if mq_len == 0 then
    for i=1,3 do
        ok, err = rds:xadd(topic, '*', "name", i * 100)
        assert(ok)
    end
end

-- read all
res, err = rds:xread('count', mq_len, 'streams', topic, 0)
if err then
    print('xread err: ', err)
end
print(cjson.encode(res))

assert(res[1][1] == topic)

local values = res[1][2]

for i,v in ipairs(values) do
    print('#', i)
    print('msg id = ', v[1])
    print('msg key = ', v[2][1])
    print('msg value = ', v[2][2])
end

-- xgroup
ok, err = rds:xgroup('create', topic, group, 0)
if err then
    if string.find(err, 'BUSYGROUP', 1, true) then
        print('group already exists')
    else
        print('xgroup err: ', err)
    end
end

-- read a msg
res, err = rds:xreadgroup('group', group, consumer,
                          'count', 1, 'streams', topic, '>')
if err then
    print('xread err: ', err)
end
print(cjson.encode(res))

if res == ngx.null or #res[1][2] == 0 then
    print('mq is all consumed')
else
    local msg_id = res[1][2][1][1]
    --ok, err = rds:xack(topic, group, msg_id)
    print('xack msg = ', msg_id)
end

-- check not acked
res, err = rds:xpending(topic, group)
print(cjson.encode(res))

-- get all pending msg
res, err = rds:xpending(topic, group, '-', '+', 10)
print(cjson.encode(res))


-- clear redis
--rds:del(topic)

ngx.say('redis ok')

