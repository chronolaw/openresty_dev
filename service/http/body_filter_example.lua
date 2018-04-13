-- Copyright (C) 2018 by chrono

if ngx.status ~= ngx.HTTP_OK then
    return
end

--local flag = ngx.var.arg_need_encode

if ngx.ctx.encode then
    ngx.arg[1] = ngx.encode_base64(ngx.arg[1])
end

