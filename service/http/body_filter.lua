-- Copyright (C) 2017 by chrono

local footer = "ocarina of time\n"

local eof = ngx.arg[2]

ngx.log(ngx.INFO, "chunk = ", ngx.arg[1], " eof = ", eof)

if not eof then
    return
end

ngx.arg[1] = ngx.arg[1] .. footer

