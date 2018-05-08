-- Copyright (C) 2018 by chrono

-- curl 127.1:82/upstream

local upstream = require "ngx.upstream"

---------------------

local names = upstream.get_upstreams()

for i,n in ipairs(names) do
    local srvs,err = upstream.get_servers(n)
    if not srvs then
        ngx.say("failed to get servers in ", n)
        goto continue
    end

    ngx.say("upstream : ", n)
    for i,s in ipairs(srvs) do
        for k,v in pairs(s) do
            ngx.print(k, "=", v, ";")
        end
        ngx.say("")
    end
    ngx.say("")

    ::continue::
end

---------------------

local peers = upstream.get_primary_peers("backend2")

for _, p in ipairs(peers) do
    ngx.say("id: ", p.id, " ; name: ", p.name)
    ngx.say("conns: ", p.conns, "; fails: ", p.fails)
    ngx.say("down: ", p.down or false)
end

upstream.set_peer_down("backend2", false, 0, true)
upstream.set_peer_down("backend2", false, 0, false)

