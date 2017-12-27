-- Copyright (C) 2017 by chrono

ngx.say(ngx.config.debug)
ngx.say(ngx.config.prefix())
ngx.say(ngx.config.nginx_version)
ngx.say(ngx.config.nginx_configure())
ngx.say(ngx.config.subsystem)
ngx.say(ngx.config.ngx_lua_version)

ngx.say(jit.os)

if ngx.config.nginx_version < 1013006 then
    ngx.say("needs latest openresty")
end

if ngx.config.ngx_lua_version < 10011 then
    ngx.say("needs latest ngx_lua")
end

if ngx.config.subsystem ~= 'http' then
    ngx.say("only works in http subsystem")
end
