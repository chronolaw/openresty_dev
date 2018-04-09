-- Copyright (C) 2018 by chrono

-- curl 127.1:81/dns

local resolver = require "resty.dns.resolver"

local r, err = resolver:new{
    nameservers = {"8.8.8.8", {"8.8.4.4", 53},
                   "4.2.2.1", "4.2.2.2"},
    timeout = 1000,
    --no_recurse = true,
}

if not r then
    ngx.say("failed to init resolver: ", err)
    return
end

local answers, err = r:query("www.openresty.org")
if not answers then
    ngx.say("failed to query DNS server: ", err)
    return
end

if answers.errcode then
    ngx.say("server returned error code: ", answers.errcode,
            ": ", answers.errstr)
end

for _, rec in ipairs(answers) do
    ngx.say(rec.name, " ", rec.address or rec.cname,
        --" type:", rec.type, " class:", rec.class,
        " ttl:", rec.ttl)
end

ngx.say("hello dns resolver")
