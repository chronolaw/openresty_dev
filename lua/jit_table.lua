#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty

local tab_new = require "table.new"

local t = tab_new(10, 0)

for i=1,10 do
    t[#t+1] = i
end

print('#t = ', #t)

local tab_clone = require "table.clone"

local t2 = tab_clone(t)

--for _,v in ipairs(t2) do
--    print(v, ',')
--end
