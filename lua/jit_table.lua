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
