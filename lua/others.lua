#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty


-- Closure
local value = 0

local function counter()
    value = value + 1
    return value
end

print(counter())
print(counter())

-- pcall
local ok, v = pcall(math.sqrt, 2)
print(ok and v)

local ok, x = pcall(require, "xxx")

if not ok then
    --print("errinfo is ", x)
end

----
local function test(...)
    local arg={...}
    print(#arg)
    print("args : ", select('#', ...))
    print((select(3, ...)))
    for i, v in ipairs(arg) do
        print("arg ", i, " is ", v)
    end
end

test(1, 2, "hello")

local x = {'hello', 'lua', 'openresty'}
print(unpack(x))
