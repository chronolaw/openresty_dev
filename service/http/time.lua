-- Copyright (C) 2017 by chrono

--print(ngx.time())
--print(ngx.now())
--print(ngx.today())

local secs = ngx.time()
local msecs = ngx.now()

assert(msecs - secs < 1)

ngx.say(ngx.today())
ngx.say(ngx.localtime())
ngx.say(ngx.utctime())

local secs = 1514442072
ngx.say(ngx.http_time(secs))
ngx.say(ngx.cookie_time(secs))

local str = "Thu, 28 Dec 2017 06:21:12 GMT"
ngx.say(ngx.parse_http_time(str))

ngx.update_time()

ngx.sleep(1.0)
ngx.say("sleep 1 second")
ngx.sleep(0.02)
ngx.say("sleep 20 miliseconds")

