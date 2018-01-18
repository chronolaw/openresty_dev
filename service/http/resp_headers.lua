-- Copyright (C) 2017-2018 by chrono

ngx.log(ngx.ERR, "now ngx.status is ", ngx.status or "-")
ngx.status = ngx.HTTP_ACCEPTED

ngx.header['Content-Type'] = 'text'
ngx.header['Server'] = 'my openresty'
ngx.header.date = nil
ngx.header.content_length = 0
ngx.header.new_field = 'xxx'

ngx.header["Cache-Control"] = "max-age=300"
