#!/usr/local/openresty/bin/resty

-- Copyright (C) 2018 by chrono

local ffi = require "ffi"

local ffi_new = ffi.new

-- 1MB
local mega = 1024 * 1024

-- 500MB
local n = 500 * mega

print "now openresty supports 2G memory on x86_64\n"

for i=1,3 do
    local ok, x = pcall(ffi_new, "char[?]", n)

    print("malloc ", i * 500, "m ",
          ok and "ok" or "failed")

    print(string.format("GC: %dMB\n", collectgarbage("count") / 1024))
end

