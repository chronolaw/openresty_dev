-- Copyright (C) 2018 by chrono

-- curl 127.1:81/redis

local redis = require "resty.redis"

local rds = redis:new()

rds:set_timeout(1000)   -- 1 sec

local ok,err = rds:connect("127.0.0.1",6379)
if not ok then
    ngx.say("failed to connect : ", err)
    rds:close()
    return
end
--assert(ok)

-- test auth
--ok, err = rds:auth('12345')
--ngx.say('auth = ', ok, ' err = ', err)

ok, err = rds:set("metroid", "prime")
assert(ok)

local res, err = rds:get("metroid")
assert(res ~= ngx.null)
assert(res == "prime")

ok, err = rds:hset('zelda', 'bow', 2017)
res, err = rds:hget('zelda', 'bow')
assert(tonumber(res) == 2017)

ok, err = rds:del('list')
ok, err = rds:lpush('list', 1,2,3,4)

res, err = rds:lpop('list')
assert(tonumber(res) == 4)

rds:init_pipeline(10)
for i=1,10 do
    ok, err = rds:rpush('numbers', i)
    if not ok then
        rds:cancel_pipeline()
    end
end

local results, err = rds:commit_pipeline()

if err then
    ngx.log(ngx.ERR, "commit_pipeline err : ", err)
end

-- 1 key num time
local scripts = [[
    local key = KEYS[1]
    local limit = ARGV[1] or 100
    local time = ARGV[2] or 60

    local count = redis.call('incr', key)

    if count == 1 then
        redis.call('expire', key, time)
    end

    return count >= limit and 'deny' or 'allow'
]]

res, err = rds:eval(scripts, 1, 'client_addr')
if res == 'allow' then
    ngx.say('allow access')
end

-- idle time 10 seconds
-- pool size 100
rds:set_keepalive(10*1000, 100)

ngx.say('redis ok')
