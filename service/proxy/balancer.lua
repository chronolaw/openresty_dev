-- Copyright (C) 2018 by chrono

local balancer = require "ngx.balancer"

local servers = {
    {"127.0.0.1", 80},
    {"127.0.0.1", 81},
}

balancer.set_timeouts(1, 0.5, 0.5)
balancer.set_more_tries(2)

local n = math.random(#servers)
ngx.log(ngx.ERR, "balance to ", servers[n][1], ":", servers[n][2])

local ok, err = balancer.set_current_peer(
                    servers[n][1], servers[n][2])

if not ok then
    ngx.log(ngx.ERR, "failed to set peer: ", err)
    return ngx.exit(500)
end

