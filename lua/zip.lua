#!/usr/local/openresty/bin/resty

-- Copyright (C) 2020 by chrono

-- git clone git@github.com:doujiang24/lua-resty-zip.git

-- safe decode
local cjson = require "cjson.safe"

local zip = require "resty.zip"

local cjson_encode = cjson.encode
local cjson_decode = cjson.decode

local zip_compress = zip.compress
local zip_uncompress = zip.uncompress

local ngx_encode_base64 = ngx.encode_base64
local ngx_decode_base64 = ngx.decode_base64

local txt = string.rep('1234', 100)

local function compress(str)

    local c = ngx_encode_base64(
                zip_compress(txt)
                )
    local obj = {len = #str, data = c}

    return cjson_encode(obj)
end

local function uncompress(str)

    local obj = cjson_decode(str)

    local s = ngx_decode_base64(obj.data)
    --print(#s)

    --local buf_len = 20 * 1024

    return zip_uncompress(s, obj.len)
end

local c = compress(txt)

print(c)
print("zip len = ", #c)

local x = uncompress(c)
print(x)
print('unzip len = ', #x)


