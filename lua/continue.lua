#!/usr/local/openresty/bin/resty

for i=1,10 do
    if i % 2 == 0 then
        goto continue
    end

    print("i = ", i)

    ::continue::
end
