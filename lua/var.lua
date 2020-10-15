#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

-- now resty do not allow global var
--local x = 1

local x = 1
assert(x == 1)

local str = 'matrix'

do
    local pi = 3.14
end

print(type(pi))

local MAX_COUNT = 1000

