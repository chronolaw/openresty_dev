-- Copyright (C) 2017 by chrono

--print(ngx.time())
--print(ngx.now())
--print(ngx.today())

local secs = ngx.time()
local msecs = ngx.now()
ngx.say(secs)

assert(msecs - secs < 1)

ngx.say(ngx.today())
ngx.say(ngx.localtime())
ngx.say(ngx.utctime())

local secs = 1514880339
ngx.say(ngx.http_time(secs))
ngx.say(ngx.cookie_time(secs))

local str = "Tue, 02 Jan 2018 08:05:39 GMT"
ngx.say(ngx.parse_http_time(str))

ngx.say(ngx.now())
ngx.update_time()
ngx.say(ngx.now())

ngx.sleep(1.0)
ngx.say("sleep 1 second")
ngx.sleep(0.02)
ngx.say("sleep 20 miliseconds")

