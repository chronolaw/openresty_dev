-- Copyright (C) 2017-2018 by chrono

local function cleanup()
    ngx.log(ngx.ERR, "client abort")
    ngx.exit(444)
end

local ok, err = ngx.on_abort(cleanup)
if not ok then
    ngx.log(ngx.ERR, "failed to register the on_abort callback: ", err)
    ngx.exit(500)
end

ngx.say("send some data")
ngx.say("sleep, pleas ctrl+c to break")
ngx.flush(true)

ngx.sleep(300)


