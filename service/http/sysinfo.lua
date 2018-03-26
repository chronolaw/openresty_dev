-- Copyright (C) 2017 by chrono

ngx.say(ngx.config.debug)
ngx.say(ngx.config.prefix())
ngx.say(ngx.config.nginx_version)
ngx.say(ngx.config.nginx_configure())
ngx.say(ngx.config.subsystem)
ngx.say(ngx.config.ngx_lua_version)

ngx.say(jit.os)

if ngx.config.nginx_version < 1013006 then
    error("needs latest openresty")
end

if ngx.config.ngx_lua_version < 10011 then
    error("needs latest ngx_lua")
end

if ngx.config.subsystem ~= 'http' then
    error("only works in http subsystem")
end

ngx.log(ngx.ERR, "some error occured")
