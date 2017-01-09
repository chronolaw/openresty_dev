-- Copyright (C) 2017 by chrono

local print = ngx.say

local str = "abcd-123"
str = ngx.re.sub(str, "ab", "cd", "jo")

print("after sub : ", str)
assert(str == "cdcd-123")

local m = ngx.re.match(str, "(.*)123$", "jo")
assert(m and m[1] == "cdcd-")
print("match : ", m[1])

local from, to = ngx.re.find(str, [[\d+]], "jo")
print("find : ", string.sub(str, from))
assert(string.sub(str, from) == "123")

str = "a/b/c"
local m = ngx.re.match(str, "(.*)/.*", "ijo")

print(m and m[1])
assert(m and m[1] == "a/b")

-- split in resty.core
local ngx_re = require "ngx.re"
local res, err = ngx_re.split("a,b,c,d", ",")
assert(res and #res == 4)
assert(res[1] == 'a' and res[4] == 'd')

local iter, err = ngx.re.gmatch("127.0.0.1,123,456,789",[[([0-9\.]+),?]], "ijo")
--local iter, err = ngx.re.gmatch("127.0.0.1",[[([0-9\.]+),?]], "ijo")
if err then
    print(err)
end

while true do
    local m, err = iter()
    if not m then
        break
    end

    print("get : ", m[1])
end

