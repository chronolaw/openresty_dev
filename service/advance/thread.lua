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

-----------------
local shmem = ngx.shared.shmem
shmem:flush_all()

local semaphore = require "ngx.semaphore"

local sema = semaphore.new(0)

local function producer(n)
    for i=1,n do
        shmem:rpush('logs', 'xxx')
        sema:post()
        ngx.sleep(0.1)
    end
end

local function consumer(n)
    for i=1,n do
        local ok, err = sema:wait(0.2)
        if not ok then
            ngx.say("failed to wait sema: ", err)
            return
        end
        local v = shmem:lpop('logs')
        ngx.say("sema get: ", v)
    end
end

ngx.say("test semaphore ...")

local threads = {
    spawn(producer, 3),
    spawn(consumer, 3),
}

wait(unpack(threads))
--ngx.sleep(1)

ngx.say('hello ngx.thread')
