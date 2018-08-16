-- Copyright (C) 2018 by chrono

local ffi = require "ffi"

local ffi_null = ffi.null
local ffi_cdef = ffi.cdef
local ffi_typeof = ffi.typeof
local ffi_new = ffi.new
local ffi_fill = ffi.fill
local ffi_copy = ffi.copy
local ffi_C = ffi.C

ffi_cdef[[
void ngx_setproctitle(char *title);
]]

local function setproctitle(title)

    local str = ffi_new("char[?]", #title + 1)

    ffi_fill(str, 0, #title + 1)
    ffi_copy(str, title, #title)

    ffi_C.ngx_setproctitle(str)
end

-- delay to change title
local function setproctitle_delay(time, title)
    ngx.timer.at(time,
            function(premature)
                setproctitle(title)
            end
            )
end

local title = "new title for worker " .. ngx.worker.id()

ngx.say("change title to : ", title)

setproctitle_delay(0.1, title)

