#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local ffi = require "ffi"

local ffi_null = ffi.null
local ffi_cdef = ffi.cdef
local ffi_new = ffi.new
local ffi_C = ffi.C

ffi_cdef[[
struct timeval {
    long int tv_sec;
    long int tv_usec;
};

int gettimeofday(struct timeval *tv, void *tz);
]]

local tm = ffi_new("struct timeval")
ffi_C.gettimeofday(tm, ffi_null)

--local sec = tonumber(tm.tv_sec)
--local usec = string.format("%06d", tonumber(tm.tv_usec))

ngx.say(type(tm.tv_sec))
ngx.say("sec:", tm.tv_sec, " usec:", tm.tv_usec)
ngx.say("sec:", tonumber(tm.tv_sec), " usec:", tonumber(tm.tv_usec))

