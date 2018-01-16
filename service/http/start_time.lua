-- Copyright (C) 2018 by chrono

ngx.sleep(0.02)
local request_time = ngx.now() - ngx.req.start_time()
--ngx.say(ngx.now(), " ", ngx.req.start_time())
ngx.say("time: ", request_time, " ", ngx.var.request_time)
