-- Copyright (C) 2017 by chrono

if ngx.get_phase ~= "header_filter" then
    return
end

local headers = {}
headers['xxx'] = 'xxx'

for k,v in pairs(headers) do
    ngx.header[k] = v
end
