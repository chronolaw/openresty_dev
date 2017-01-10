-- Copyright (C) 2017 by chrono

local footer = "ocarina of time\n"

ngx.log(ngx.INFO, "chunk = ", ngx.arg[1], " eof = ", ngx.arg[2])

if not ngx.arg[2] then
    return
end

ngx.arg[1] = ngx.arg[1] .. footer

