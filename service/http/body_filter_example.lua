-- Copyright (C) 2017 by chrono

local flag = ngx.var.arg_need_encode

if flag then
    ngx.arg[1] = ngx.encode_base64(ngx.arg[1])
end

