-- Copyright (C) 2017-2018 by chrono

local ssl = require "ngx.ssl"
local byte = string.byte

local function addr_str(addr)
    return string.format("%d.%d.%d.%d", byte(addr, 1), byte(addr, 2),
            byte(addr, 3), byte(addr, 4))
end

ngx.say("scheme: ", ngx.var.scheme)

local name, err = ssl.server_name()
ngx.say("sni: ", name)

local ver, err = ssl.get_tls1_version()
ngx.say("ver: ", string.format("0x%x", ver))

if ver < ssl.TLS1_VERSION then
    ngx.say("do not support")
    ngx.exit(444)
end

local ver, err = ssl.get_tls1_version_str()
ngx.say("ver: ", ver)

ngx.say("ssl_cipher: ", ngx.var.ssl_cipher)
ngx.say("ssl_ciphers: ", ngx.var.ssl_ciphers)

local addr, addrtyp, err = ssl.raw_client_addr()
ngx.say(addrtyp, ": ", addr_str(addr))

local addr, addrtyp, err = ssl.raw_server_addr()
ngx.say(addrtyp, ": ", addr_str(addr))

ngx.say('hello openresty')
