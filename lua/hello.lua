#!/usr/local/openresty/bin/resty

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty

-- emulate lua 5.1 print
--local print = ngx.say

print("hello lua")

local n = #arg
print("args count = ", n)
for i = 1,n do
    print("arg ", n , ": ", arg[i])
end

