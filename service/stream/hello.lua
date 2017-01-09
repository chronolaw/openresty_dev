-- Copyright (C) 2017 by chrono

ngx.log(ngx.ERR, "test openresty with stream")

ngx.say("hello ",
    ngx.config.subsystem, " ",ngx.var.remote_addr)
