#!/usr/local/openresty/bin/resty

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty

-- emulate lua 5.1 print
local print = ngx.say

print("hello lua")

