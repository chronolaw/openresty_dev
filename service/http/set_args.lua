-- Copyright (C) 2018 by chrono

-- curl '127.1:80/set_args'

local args = {a=1, b={'#','%'}}
ngx.req.set_uri_args(args)
ngx.say(ngx.var.args)

