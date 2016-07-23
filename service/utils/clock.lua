-- Copyright (C) 2016 by chrono

local floor = math.floor

local proto = { _VERSION = '0.01' }

local mt = { __index = proto }

function proto:new()
    return setmetatable(
        {clock = ngx.now()}, mt
    );
end

-- get time in milli seconds
function proto:elapsed()
    return floor((ngx.now() - self.clock)*1000)
end

return proto
