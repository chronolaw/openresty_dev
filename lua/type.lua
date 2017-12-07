#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

print(type(nil))            -- nil
print(type(true))           -- boolean
print(type(42))             -- number
print(type(2.718))          -- number
print(type("metroid"))      -- string
print(type(print))          -- function
print(type(table))          -- table

local x

x = 2017
x = "lua"
x = nil

assert(not x)

