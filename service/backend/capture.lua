-- Copyright (C) 2018 by chrono

-- curl 127.1:81/capture

ngx.say('now capture proxy_pass:\n')

local capture = ngx.location.capture

local res = capture('/hello')

if res.status ~= ngx.HTTP_OK then
    ngx.exit(res.status)
end

ngx.print(res.body)


ngx.say('\nnow capture redis2_pass:\n')

local res = capture('/ngx_redis2',
                {args = {key='metroid'}})

ngx.print(res.body)
