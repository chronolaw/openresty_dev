-- Copyright (C) 2018 by chrono

local function action_get()
    local t = ngx.time()
    ngx.say(ngx.http_time(t))
end

local function action_post()
    ngx.req.read_body()
    local data = ngx.req.get_body_data()
    local num = tonumber(data)

    if not num then
        ngx.log(ngx.ERR, "no body data found")
        ngx.exit(400)
    end

    ngx.say(ngx.http_time(num))
end

local actions = {
    GET = action_get,
    POST = action_post
    }

local method = ngx.req.get_method()

-- run
actions[method]()

