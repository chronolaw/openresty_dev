#!/usr/local/openresty/bin/resty

local bit = require "bit"

local band, bor = bit.band, bit.bor
local bxor, bnot = bit.bxor, bit.bnot
local blshift = bit.lshift
local tohex = bit.tohex

local x, y = 1, 4
print(band(x, y))
print(bor(x, y))
print(bxor(x, y))
print(tohex(bnot(x)))
print(blshift(y, 1))

local byte = string.byte
local data = '\000\000\001\001'

local a,b,c,d = byte(data, 1, 4)

local x = blshift(a, 24) + blshift(b, 16) +
          blshift(c,  8) + d

print(x)
