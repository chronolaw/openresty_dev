-- Copyright (C) 2018 by chrono

-- curl 127.1:82/upstream

local upstream = require "ngx.upstream"

local name = upstream.current_upstream_name()
local addr = ngx.var.upstream_addr

ngx.log(ngx.ERR, "proxy to: ", name)

local srvs,err = upstream.get_primary_peers(name)
for _,s in ipairs(srvs) do
    if string.find(addr, s.name, 1, true) then
        ngx.log(ngx.ERR, "use srv id: ", s.id)
    end
end
