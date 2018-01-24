-- Copyright (C) 2018 by chrono

local method = ngx.req.get_method()
if method ~= 'GET' and
   method ~= 'POST' then

   ngx.header['Allow'] = 'GET, POST'
   ngx.exit(405)
end

local ver = ngx.req.http_version()
if ver < 1.1 then
   ngx.exit(400)
end

ngx.header.content_length = nil

