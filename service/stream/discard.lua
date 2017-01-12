-- Copyright (C) 2017 by chrono

local sock = assert(ngx.req.socket())

-- 3 seconds
sock:settimeout(3000)

local count = 0

-- discard all received data
while true do
    local data, err = sock:receive(1)   -- 1bytes buffer

    if not data or err then
        ngx.log(ngx.ERR, "received error : ", err)
        break
    end

    count = count + 1

    if count % 100 == 0 then
        ngx.log(ngx.INFO, " received ", count , " bytes")
    end
end

ngx.exit()
