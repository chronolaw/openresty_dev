#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

print('openresty')
print("It's OK")
print("lua\tnginx")

print([[raw string \r\n]])
print([[^\d+.\d+$]])
print([["",'',""]])

local x = [=[
[[no \r\n, just one line]]
]=]
print(x)

