-- Copyright (C) 2017-2018 by chrono

-- curl -k https://www.chrono.com:84/hello
-- curl -k https://www.metroid.net:84/hello

local ssl = require "ngx.ssl"

local phase = ngx.get_phase()
if phase ~= "ssl_cert" then
    ngx.log(ngx.ERR, "ssl can't run in ", phase)
    ngx.exec("/")
    return
end

ngx.log(ngx.ERR, "enter ssl_certificate_by_lua")

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
    local prefix = ngx.config.prefix().."conf/ssl/"

    for k,_ in pairs(certs) do
        local name = certs[k].name

        certs[k].cert = get_pem(prefix..name..'.crt')
        certs[k].key = get_pem(prefix..name..'.key')

        --ngx.log(ngx.ERR, "cert=", #certs[k].cert)
        --ngx.log(ngx.ERR, "key=", #certs[k].key)
    end
end

-- read certs from disk or redis ...
init_certs()

local name, err = ssl.server_name()
if not name then
    ngx.log(ngx.ERR, "no SNI found: ", err)
    ngx.exit(ngx.ERROR)
end

--ngx.ctx.sni = name

local ok, err = ssl.clear_certs()
if not ok then
    ngx.log(ngx.ERR, "clear cert failed: ", err)
    ngx.exit(ngx.ERROR)
end

local cert, err = ssl.parse_pem_cert(certs[name].cert)
if not cert then
    ngx.log(ngx.ERR, "failed to parse cert: " , err)
    ngx.exit(ngx.ERROR)
end

local ok, err = ssl.set_cert(cert)
if not ok then
    ngx.log(ngx.ERR, "failed to set cert: " , err)
    ngx.exit(ngx.ERROR)
end

local key, err = ssl.parse_pem_priv_key(certs[name].key)
if not key then
    ngx.log(ngx.ERR, "failed to parse key: " , err)
    ngx.exit(ngx.ERROR)
end

local ok, err = ssl.set_priv_key(key)
if not ok then
    ngx.log(ngx.ERR, "failed to set key: " , err)
    ngx.exit(ngx.ERROR)
end

