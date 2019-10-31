#!/usr/local/openresty/bin/resty

-- Copyright (C) 2019 by chrono

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty

-- https://github.com/chronolaw/lua-protobuf
-- gcc -O2 -shared -fPIC -I/usr/local/include/luajit-2.1 pb.c -o pb.so
-- cp pb.so protoc.lua /usr/local/openresty/lualib

local pb = require "pb"

-- protoc -o test.pb test.proto
--assert(pb.loadfile("test.pb"))

local protoc = require "protoc"

print("test lua protobuf")

local pbdef = [[
syntax = "proto2";
package test;

message http_info {
    required uint64  id     = 1;
    optional string  name   = 2;

    repeated string  fields = 3;
}
]]

assert(protoc:load(pbdef))

local obj = {
    id = 42,
    name = 'galaxy',
    fields = {'a', 'b', 'c'},
}

local bytes = assert(pb.encode("test.http_info", obj))
print(pb.tohex(bytes))

local obj2 = assert(pb.decode("test.http_info", bytes))

assert(obj2.id == obj.id)
assert(obj2.name == obj.name)

local cjson = require "cjson.safe"

print(cjson.encode(obj2))
