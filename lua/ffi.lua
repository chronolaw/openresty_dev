#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local ffi = require "ffi"

local ffi_null = ffi.null
local ffi_cdef = ffi.cdef
local ffi_typeof = ffi.typeof
local ffi_new = ffi.new
local ffi_C = ffi.C

ffi_cdef[[
struct timeval {                // this is a comment
    long int tv_sec;
    long int tv_usec;
};

int gettimeofday(struct timeval *tv, void *tz);
]]

local timeval_t = ffi_typeof("struct timeval")
local tm = ffi_new(timeval_t)
ffi_C.gettimeofday(tm, ffi_null)

--local sec = tonumber(tm.tv_sec)
--local usec = string.format("%06d", tonumber(tm.tv_usec))

print(type(tm.tv_sec))
print("sec:", tm.tv_sec, " usec:", tm.tv_usec)
print("sec:", tonumber(tm.tv_sec), " usec:", tonumber(tm.tv_usec))

