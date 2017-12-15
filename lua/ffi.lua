#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

local ffi = require "ffi"

local ffi_null = ffi.null
local ffi_cdef = ffi.cdef
local ffi_typeof = ffi.typeof
local ffi_new = ffi.new
local ffi_C = ffi.C

--------------------------

ffi_cdef[[
struct dummy{};
double sqrt(double x);
int gethostname(char *name, size_t len);
]]

local int_t = ffi.typeof("int")
local char_arr_t = ffi.typeof("char[?]")

local a_int = ffi.new(int_t)
local char_arr = char_arr_t(10)

local x = ffi.C.sqrt(5)
print(x)

ffi.fill(char_arr, 10)
ffi.C.gethostname(char_arr, 10)
print(char_arr)
print(ffi.string(char_arr))

--------------------------

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

