-- Copyright (C) 2017 by chrono

local uri = '/hello'
local args = 'chrono'

local res = ngx.location.capture(
                uri,
                {args=args})

ngx.say(res.status)
ngx.print(res.body)
