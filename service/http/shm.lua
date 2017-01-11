-- Copyright (C) 2017 by chrono

local stats = ngx.shared.stats

local ok, err

ok, err = stats:set("count", 1, 10)
assert(ok and not err)

local v = stats:get("count")
assert(v == 1)

local id = stats:incr("uid", 0, 1)
assert(id == 1)

local len

len = stats:rpush("sessions", "xxx")
assert(len == 1)

v = stats:lpop("sessions")
assert(v == "xxx")

stats:flush_all()

ngx.say("test shm ok")
