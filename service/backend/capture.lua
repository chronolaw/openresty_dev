-- Copyright (C) 2018 by chrono

-- curl 127.1:81/capture

ngx.say('now capture proxy_pass:\n')

local capture = ngx.location.capture

local res = capture('/hello')

if res.status ~= ngx.HTTP_OK then
    ngx.exit(res.status)
end

if res.truncated then
    ngx.log(ngx.ERR, "data truncated")
end
ngx.print(res.body)

ngx.say()
ngx.say('now capture redis2_pass:\n')

local res = capture('/ngx_redis2',
                {args = {key='metroid'}})

ngx.print(res.body)

---------------
ngx.say('now capture multi:\n')

local capture_multi = ngx.location.capture_multi

local res1, res2 = capture_multi{
                    {'/hello'},
                    {'/ngx_redis2', {args = {key='metroid'}}}
}

ngx.print(res1.body)
ngx.print(res2.body)
