-- Copyright (C) 2017-2018 by chrono

local ssl = require "ngx.ssl"
local ocsp = require "ngx.ocsp"
local http = require "resty.http"

local phase = ngx.get_phase()

local function get_pem(file)
    local f = io.open(file, 'r')
    if not f then
        return
    end

    local str = f:read("*a")
    f:close()

    return str
end

local prefix = ngx.config.prefix().."conf/ssl/"
local cert = get_pem(prefix..'chrono.crt')

local der_cert, err = ssl.cert_pem_to_der(cert)
if err then
    ngx.log(ngx.ERR, "failed to der: ", err)
    ngx.exit(ngx.ERROR)
end

local ocsp_url, err = ocsp.get_ocsp_responder_from_der_chain(der_cert)
if not ocsp_url then
    ngx.log(ngx.ERR, "failed to get OCSP responder: ", err)
    --ngx.exit(ngx.ERROR)
    ocsp_url = "http://ocsp.digicert.com"
end

if phase ~= "ssl_cert" then
    ngx.say("ocsp url: ", ocsp_url)
    --ngx.log(ngx.ERR, "ocsp url: ", ocsp_url)
end

local ocsp_req, err = ocsp.create_ocsp_request(der_cert)
if not ocsp_req then
    ngx.log(ngx.ERR, "failed to create OCSP request: ", err)
    ngx.exit(ngx.ERROR)
end

local httpc = http.new()
httpc:set_timeout(10000)
local res, err = httpc:request_uri(ocsp_url, {
        method = "POST",
        body = ocsp_req,
        headers = {
            ["Content-Type"] = "application/ocsp-request",
        }
})

if not res then
    ngx.log(ngx.ERR, "OCSP responder query failed: ", err)
    ngx.exit(ngx.ERROR)
end

if res.status ~= 200 then
    ngx.log(ngx.ERR, "OCSP responder returns: ", res.status)
    ngx.exit(ngx.ERROR)
end

ngx.say("OCSP responder query:", res.status)

local ocsp_resp = res.body
