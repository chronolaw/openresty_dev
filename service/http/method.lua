-- Copyright (C) 2018 by chrono

ngx.say(ngx.req.get_method())

local methods = {GET=ngx.HTTP_GET, POST=ngx.HTTP_POST}
--ngx.req.set_method(ngx.HTTP_POST)
ngx.req.set_method(methods["POST"])

ngx.say(ngx.req.get_method())

