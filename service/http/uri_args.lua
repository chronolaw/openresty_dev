-- Copyright (C) 2018 by chrono

-- curl '127.1:80/req?a=1&b=2&b=3'

local args = ngx.req.get_uri_args(20)
for k,v in pairs(args) do
    ngx.say("args: ", k, "=", v)
end
if type(args.b) == "table" then
    ngx.say("b is :", table.concat(args.b, " "))
end

