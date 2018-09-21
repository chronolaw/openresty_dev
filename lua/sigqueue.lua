#!/usr/local/openresty/bin/resty

-- Copyright (C) 2018 by chrono

-- should sudo this !!
-- it also can be run in luajit command

local ffi = require "ffi"

local ffi_null = ffi.null
local ffi_cdef = ffi.cdef
local ffi_typeof = ffi.typeof
local ffi_new = ffi.new
local ffi_C = ffi.C

-- man 3 sigqueue
ffi_cdef[[
    typedef int pid_t;
    union sigval {
        int   sival_int;
        void *sival_ptr;
    };

    int sigqueue(pid_t pid, int sig, const union sigval value);
]]

if #arg < 3 then
    print("usage: sigqueue pid sig value")
    return
end

local pid = tonumber(arg[1])
local sig = tonumber(arg[2])

local value = ffi_new("union sigval")
value.sival_int = tonumber(arg[3])

local rc = ffi_C.sigqueue(pid, sig, value)

print("sigqueue return " .. rc)
