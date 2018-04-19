-- Copyright (C) 2017-2018 by chrono

-- curl 127.1:83/thread

local spawn = ngx.thread.spawn

local function task1(v)
    ngx.say("query redis: ", v)
end

local function task2(v)
    ngx.say("query mysql: ", v)
end

local t1 = spawn(task1, "here")
local t2 = spawn(task2, "there")

-----------------

local wait = ngx.thread.wait

local function job(time)
    ngx.sleep(time)
    ngx.say("job fin in ", time)
    return time
end

local threads = {
    spawn(job, 0.10),
    spawn(job, 0.20),
    spawn(job, 0.05),
}

-- local ok, v = wait(unpack(threads))
-- ngx.say("wait = ", ok, " v = ", v)

for i,t in ipairs(threads) do
    local ok, v = wait(t)
    ngx.say("wait ", v)
end

-----------------

local function f()
    local co = coroutine.running()
    ngx.say(1)
    coroutine.yield(co)
    ngx.say(2)
end

local function g()
    local co = coroutine.running()
    ngx.say('a')
    coroutine.yield(co)
    ngx.say('b')
end

spawn(f);spawn(g)

-----------------

local kill = ngx.thread.kill

local threads = {
    spawn(job, 0.10),
    spawn(job, 0.20),
    spawn(job, 0.05),
}

local ok, v = wait(unpack(threads))
for i,t in ipairs(threads) do
    ngx.say("kill ", i, " is ", kill(t))
end

ngx.say('hello ngx.thread')
