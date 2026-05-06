
-- This module handles data storage and serialization. Contract data should preferably persist between sessions.

local Identifier = require('identifier')

local Storage = {}

-- Initialize an load stored data.
function Storage.init()
    local s = Util.optStorage(City.getStorage(), Identifier.get())

    s.contracts = s.contracts or {
        active = {},
        completed = {}
    }

    return s
end

return Storage
