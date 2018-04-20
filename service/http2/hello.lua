-- Copyright (C) 2017-2018 by chrono

local ssl = require "ngx.ssl"

ngx.say("scheme: ", ngx.var.scheme)

ngx.say("http version: ", ngx.req.http_version())

local name, err = ssl.server_name()
ngx.say("sni: ", name)

local ver, err = ssl.get_tls1_version_str()
ngx.say("tls:", ver)

ngx.say('hello openresty http2')
