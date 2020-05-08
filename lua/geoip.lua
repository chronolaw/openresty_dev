#!/usr/local/openresty/bin/resty

-- Copyright (C) 2020 by chrono


local cjson = require "cjson.safe"

print('hello geoip')

-- https://github.com/anjia0532/lua-resty-maxminddb
-- get full info
--[[
local geo = require 'resty.maxminddb'
if not geo.initted() then
  geo.init("/mnt/share/GeoLite2-City.mmdb")
end
--]]

-- https://github.com/lilien1010/lua-resty-maxminddb
-- get counry
local resty_mmdb = require("resty.maxminddb")

local mmdb = resty_mmdb.new('/mnt/share/GeoLite2-City.mmdb')

--local ip = '1.1.1.1'              -- au
local ip = '8.8.8.8'              -- us
--local ip = '114.114.114.114'      -- cn
--local ip = '0.0.0.0'              -- nil
--local ip = '999.999.999.999'        -- nil

local res, err = mmdb:get_area_code(ip)
--local res, err = geo.lookup(ip)

if err then
    print(err)
end

print(cjson.encode ({res}) )
print(type(res), "=>", res)
