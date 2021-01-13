#!/usr/local/openresty/bin/resty

-- Copyright (C) 2020 by chrono

-- https://blog.csdn.net/gqtcgq/article/details/52076997

local arr = {
    'a',
    'b',
    'c',
}

local w = {
    1,
    3,
    4,
}

local function gcd(a, b)
    local c

    while b>0 do
        c = b
        b = a % b
        a = c
    end

    return a
end

local function get_gcd()
    local x = w[1]

    for i=2, #w do
        x = gcd(x, w[i])
    end

    return x
end

local function get_max()
    local x = w[1]

    for i=2, #w do
        if x < w[i] then
            x = w[i]
        end
    end

    return x
end

local function get_sum()
    local x = 0

    for _,v in ipairs(w) do
        x = x + v
    end

    return x
end

local g = get_gcd()
local max = get_max()
local sum = get_sum()

local idx = 1
local cur_w = max

local function rr()

    if idx > #w then
        idx = 1
        cur_w = cur_w - g

        if cur_w <= 0 then
            cur_w = max
        end
    end

    for i=idx,#w do
        if w[i] >= cur_w then
            idx = i + 1
            return arr[i]
        end
    end
end

print('g=', g)
for i=1,sum do
    print('rr=', rr())
end

--print(rr())
