#!/usr/local/openresty/bin/resty

-- Copyright (C) 2020 by chrono

local cjson = require "cjson.safe"
local etcd = require "resty.etcd"

print("test etcd")

local cli, err = etcd.new {
        protocol = 'v2',
        http_host = 'http://127.0.0.1:2379',
        timeout = 2,
    }

if err then
    print('etcd err : ', err)
    return
end

print(cli.timeout)

local res, err

res, err = cli:version()

if err then
    print('etcd version err : ', err)
    return
end

--print('etcd = ', cjson.encode(res))
print('etcd = ', res.status)
print('etcd ver = ', res.body.etcdserver)
for k,v in pairs(res.headers) do
    print(k , '=>', v)
end

res, err = cli:set('/test/akey', 'xxx')
assert(res.body.action == 'set')
print('set = ', cjson.encode(res.body))

res, err = cli:get('/test/akey')
assert(res.body.node.value == 'xxx')
assert(res.body.action == 'get')
print('set = ', cjson.encode(res.body))

