-- Copyright (C) 2017-2018 by chrono

local ssl = require "ngx.ssl"

local function get_pem(file)
    local f = io.open(file, 'r')
    if not f then
        return
    end

    local str = f:read("*a")
    f:close()

    return str
end

local certs = {
    ['www.chrono.com'] = {name='chrono'},
    ['www.metroid.net'] = {name='metroid'}
    }

local function init_certs()
    local prefix = ngx.config.prefix().."/conf/ssl/"

    for k,_ in pairs(certs) do
        local name = certs[k].name

        certs[k].cert = get_pem(prefix..name..'.crt')
        certs[k].key = get_pem(prefix..name..'.key')
    end
end

local name, err = ssl.server_name()
if not name then
    ngx.log(ngx.ERR, "no SNI found: ", err)
    return ngx.exit(ngx.ERROR)
end

--ngx.ctx.sni = name

local ok, err = ssl.clear_certs()
if not ok then
    ngx.log(ngx.ERR, "clear cert failed: ", err)
    return ngx.exit(ngx.ERROR)
end
