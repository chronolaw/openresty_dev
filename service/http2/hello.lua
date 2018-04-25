-- Copyright (C) 2017-2018 by chrono

-- curl --http2 -k 'https://127.1:85/hello'

local ssl = require "ngx.ssl"

ngx.say("scheme: ", ngx.var.scheme)

ngx.say("http version: ", ngx.req.http_version())

local name, err = ssl.server_name()
ngx.say("sni: ", name)

local ver, err = ssl.get_tls1_version_str()
ngx.say("tls:", ver)

-- h2: http2 with ssl
-- h2c: http2 with cleartext
ngx.say(ngx.var.http2)

ngx.say('hello openresty http2')
