-- Copyright (C) 2017 by chrono

local headers = {}
headers['x-name'] = 'chrono'
headers['x-value'] = 'trigger'

local footer = "ocarina of time\n"

local function header_filter()
    for k,v in pairs(headers) do
        ngx.header[k] = v
    end

    --local len = tonumber(ngx.header.content_length)
    --if len and len > 0 then
    --    ngx.header.content_length = len + #footer
    --end
end

local function body_filter()
    local buf = ngx.arg[1]
    local eof = ngx.arg[2]

    ngx.log(ngx.ERR, "buf = ", buf, " eof = ", eof)
    if not eof then
        return
    end

    ngx.arg[1] = buf .. footer
end

if ngx.get_phase() ~= "header_filter" then
    header_filter()
elseif ngx.get_phase ~= "body_filter" then
    body_filter()
else
    -- do nothing
end

