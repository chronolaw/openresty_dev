#!/usr/local/openresty/bin/resty

-- Copyright (C) 2017 by chrono

-- alternative :
-- #!/usr/bin/env /usr/local/openresty/bin/resty

local x = {}
x.name = 'snake'
x.mission = function() end

local proto = {}

local mt = { __index = proto }

function proto.go()
    print("go pikachu")
end

function proto.new()
    return setmetatable({name='pokemon'}, mt)
end

function proto:hello()
    print("hello ", self.name)
end

local obj = setmetatable({}, mt)

obj.go()

local obj = setmetatable({}, { __index = proto })
obj.go()

local obj = proto:new()
obj:hello()

