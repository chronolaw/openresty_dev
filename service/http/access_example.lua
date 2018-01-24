-- Copyright (C) 2018 by chrono

--local black_list = {}
local white_list = {['127.0.0.1']=1}

local ip = ngx.var.remote_addr
if --black_list[ip] or
   not white_list[ip] then
    ngx.log(ngx.ERR, ip, " is blocked")
    ngx.exit(403)
end

