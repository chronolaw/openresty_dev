-- Copyright (C) 2018 by chrono

-- curl 127.1/post_args -d 'a=1&b=2&b=3'

ngx.req.read_body()

local args = ngx.req.get_post_args(10)
for k,v in pairs(args) do
    ngx.say("args: ", k, "=", v)
end

if type(args.b) == "table" then
    ngx.say("b is :", table.concat(args.b, " "))
end

