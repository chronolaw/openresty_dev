-- Copyright (C) 2017 by chrono

local print = ngx.say

--- options

local str = "abcdXYZ-123"
print(ngx.re.match(str, [[\w+]], "ad")[0])
print(ngx.re.match(str, [[\w+z]], "ijo")[0])
print(ngx.re.match(str, [[z.\d+(?#num)]], "ijox")[0])

--- match
local str = "abcd-123"

local m = ngx.re.match(str, [[\d{3}]], "jo")
assert(m and m[0] == "123")

local m = ngx.re.match(str, "(.*)123$", "jo")
assert(m and m[1] == "abcd-")

local m = ngx.re.match(str, "[A-Z]+", "jo")
assert(not m)

local ctx = {pos = 7}
local m = ngx.re.match(str, "[0-9]", "", ctx)
assert(m and m[0] == "2" and ctx.pos == 8)

local tab_clear = require "table.clear"
tab_clear(m)
ctx.pos = 1
ngx.re.match(str, "(.*)-(.*)$", "", ctx, m)
assert(m and m[2] == "123")

--- gmatch

local str = "127.0.0.1,123,456,789"

local iter, err = ngx.re.gmatch(str, [[([0-9\.]+),?]], "ijo")
if not iter then
    print(err)
end

while true do
    local m, err = iter()
    if not m or err then
        break
    end

    print("get : ", m[1])
end

--- find
local str = "abcd-123"

local found = ngx.re.find(str, "123", "jo")
assert(found)

local from, to = ngx.re.find(str, [[\d+]], "jo")
print("find : ", string.sub(str, from))
assert(string.sub(str, from) == "123")

local from, to = ngx.re.find(str, [[(\d)(\d+)]], "", nil, 2)
assert(string.sub(str, from) == "23")

--- sub

local str = "abcd-123"
str = ngx.re.sub(str, "ab", "cd", "jo")

print("after sub : ", str)
assert(str == "cdcd-123")

str = ngx.re.sub(str, [[(\w+)-(\d+)]], "($1)($2)($1)")
print("after sub : ", str)
assert(str == "(cdcd)(123)(cdcd)")

str = ngx.re.sub(str, [[\w+]], "$$")
print("after sub : ", str)

local func = function(m)
    return "**" .. m[0] .. "**"
end

str = ngx.re.sub(str, [[\d+]], func)
print("after sub : ", str)

--- gsub

local str = "abcd-123"
str = ngx.re.gsub(str, "[a-z]{2}", "xyz", "jo")
print("after gsub : ", str)

str = ngx.re.gsub(str, [[\w+]],
    function(m) return "("..m[0]..")" end)
print("after gsub : ", str)

--- split

local ngx_re_split = require("ngx.re").split
local res, err = ngx_re_split("a,b,c,d", ",")
assert(res and #res == 4)
assert(res[1] == 'a' and res[4] == 'd')

------

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

