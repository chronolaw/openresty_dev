-- Copyright (C) 2016 by chrono

local data = "hello"

ngx.header["Content-length"] = #data
--ngx.header.content_length = #data

ngx.log(ngx.ERR, "test openresty")

ngx.print(data)

ngx.exit(200)
