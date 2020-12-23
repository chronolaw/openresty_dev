#!/usr/local/openresty/bin/resty

-- Copyright (C) 2020 by chrono

local cjson = require "cjson.safe"
local http = require "resty.http"

local master_host = 'http://127.0.0.1:9333'
--local volume_host = 'http://127.0.0.1:8080'
local filer_host = 'http://127.0.0.1:8888'

-- cache volume's url
-- should use lru_cache
local volumes = {}

local httpc
local res, err

httpc, err = http:new()

if err then
    print('http err : ', err)
end

httpc:set_timeout(2 * 1000)

-- save to fid
-- curl http://localhost:9333/dir/assign

res, err = httpc:request_uri(
            master_host .. '/dir/assign')

if err then
    print('http err : ', err)
end

print(res.body)

-- echo 123 > a.txt
-- curl -F file=@a.txt http://127.0.0.1:8080/7,1477f3bb59  --trace-ascii -
-- curl -X DELETE http://127.0.0.1:8080/7,1477f3bb59 -v
-- curl http://127.0.0.1:8080/7,1477f3bb59 -v

-- we can use ngx.re.match to get fid
local info = cjson.decode(res.body)

local vid = tonumber(string.match(info.fid, '%d+'))
print('vid = ', vid)

--if not volumes[vid] then
--    volumes[vid] = info.url
--end

local boundary = '00002020'

local body = '--' .. boundary ..'\r\n' ..
             --'Content-Disposition: form-data; name="file"; filename="xxx"\r\n' ..
             --'Content-Disposition: form-data;\r\n' ..
             'Content-Type: application/octet-stream\r\n' ..
             '\r\n' ..
             '1234' .. '\r\n' ..
             '--' .. boundary ..'--\r\n'
local headers = {
                 ['Content-Type'] = 'multipart/form-data; boundary='.. boundary,
                 ['Content-Length'] = #body
                }
print(body)

res, err = httpc:request_uri(
            'http://' .. info.url,
            --'http://' .. volumes[vid], --info.url,
            {
                path = '/' .. info.fid,
                method = 'POST',
                headers = headers,
                body = body,
            }
    )

if err then
    print('http err : ', err)
end

print(res.body)

-- read from fid
print('fid = ', info.fid)

res, err = httpc:request_uri(
            'http://' .. info.url,
            {
                path = '/' .. info.fid,
            }
    )

print(err or 'ok')
print('read fid = ', res.body)

-- directly submit to master

local body = '--' .. boundary ..'\r\n' ..
             --'Content-Disposition: form-data;\r\n' ..
             'Content-Type: application/octet-stream\r\n' ..
             '\r\n' ..
             'submit' .. '\r\n' ..
             '--' .. boundary ..'--\r\n'

local headers = {
                 ['Content-Type'] = 'multipart/form-data; boundary='.. boundary,
                 ['Content-Length'] = #body
                }

res, err = httpc:request_uri(
            master_host,
            {
                path = '/submit',
                method = 'POST',
                headers = headers,
                body = body,
            }
    )

print('submit return = ', res.body)

--[==[
-- save file

-- curl -F file=@a.txt "http://localhost:8888/txt/" --trace-ascii -

--local filename =  'xxx.jpg'
local body = '--' .. boundary ..'\r\n' ..
             'Content-Disposition: form-data; name="file"; filename="xxx.jpg"\r\n' ..
             'Content-Type: application/octet-stream\r\n' ..
             '\r\n' ..
             'xxx' .. '\r\n' ..
             '--' .. boundary ..'--\r\n'

local headers = {
                 ['Content-Type'] = 'multipart/form-data; boundary='.. boundary,
                 ['Content-Length'] = #body
                }

res, err = httpc:request_uri(
            filer_host,
            {
                path = '/storage/',
                method = 'POST',
                headers = headers,
                body = body,
            }
    )

print(res.body)

-- read file
res, err = httpc:request_uri(
            filer_host,
            {
                path = '/storage/xxx.jpg',
            }
    )

print('len = ', res.headers['Content-Length'])
--for k,v in pairs(res.headers) do
--    print(k , '=>', v)
--end
print('read = ', res.body)

--]==]
