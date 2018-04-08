-- Copyright (C) 2018 by chrono

local lrucache = require "resty.lrucache"

local urls, err = lrucache.new(100)
if not urls then
    ngx.say("failed to create cache : ", err)
    return
end

-- put into package
-- package.loaded.urls = urls

urls:set('github', 'www.github.com')
urls:set('apple', 'www.apple.com', 0.1)
urls:set('nginx',{https=true})

local v = urls:get('github')
ngx.say(v)

ngx.sleep(0.15)
local v, stale = urls:get('apple')
assert(not v and stale)
ngx.say(stale)

urls:delete('nginx')
assert(not urls:get('nginx'))
