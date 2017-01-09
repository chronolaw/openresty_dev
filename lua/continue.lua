#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

for i=1,10 do
    if i % 2 == 0 then
        goto continue
    end

    print("i = ", i)

    ::continue::
end
