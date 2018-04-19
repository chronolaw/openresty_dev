-- Copyright (C) 2017-2018 by chrono

local ssl = require "ngx.ssl"

ngx.say("scheme: ", ngx.var.scheme)

local name, err = ssl.server_name()
ngx.say("sni: ", name)

local ver, err = ssl.get_tls1_version()
ngx.say("ver:", ver)

local ver, err = ssl.get_tls1_version_str()
ngx.say("ver:", ver)

--local addr, addrtyp, err = ssl.raw_client_addr()
--ngx.say("client addr: ", addrtyp, addr)

local addr, addrtyp, err = ssl.raw_server_addr()
ngx.say("server addr: ", addrtyp, addr)

ngx.say('hello openresty')
