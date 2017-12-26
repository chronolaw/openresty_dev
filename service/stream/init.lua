-- Copyright (C) 2017 by chrono

if not ngx.config
    or not ngx.config.ngx_lua_version
    or ngx.config.ngx_lua_version < 4
then
    return
end

require "resty.core"
collectgarbage("collect")  -- just to collect any garbage

--ngx.log(ngx.ALERT, "init. only a test log")

