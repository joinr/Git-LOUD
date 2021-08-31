
local HookedFiles = { }

--- Hooks all functions in the upper-level table, providing safety guards to ensure we 
-- do not hook a table twice by accident. Does not recurse into sub tables.
-- @param tracker The table that we can use to store the profiler results.
-- @param tableWithFunctions The table with functions that we want to hook.
-- @param exceptions Functions that we do not want to profile, such as import.
function Hook(identifier, tableWithFunctions, exceptions)

    -- make sure we don't hook multiple times
    if HookedFiles[identifier] then 
        WARN("Profiler - tried to hook a file that is already hooked by the profiler, skipping " .. table)
        return
    end

    HookedFiles[HookedFiles] = true

    -- initialise hook table
    local simModel = import("/mods/profiler/modules/sim/model.lua")
    simModel.TableCounters[identifier] = simModel.TableCounters[identifier] or { }
    local tracker = simModel.TableCounters[identifier]

    -- initialize the tracker
    tracker.LuaFunctions = tracker.LuaFunctions or { }

    -- iterate over the table to find functions
    for k, element in tableWithFunctions do 

        -- skip those we're not interested in, like import
        if exceptions[k] then 
            continue
        end

        -- make sure we can use k as an index
        local typeK = type(k)
        if not (typeK == "string" or typeK == "number") then 
            SPEW("Profiler - Skipping unknown type (" .. typeK .. ") in file " .. file)
            continue
        end

        -- hook functions to keep count
        typeElement = type(element)
        if typeElement == "function" or typeElement == "cfunction" then 

            -- uplift the for loop iterator values
            local localK = k
            local localElement = element

            local old = tableWithFunctions[localK]
            tableWithFunctions[localK] = function(...)
                -- keep track how often we called this function
                tracker.LuaFunctions[localK] = tracker.LuaFunctions[localK] or 0
                tracker.LuaFunctions[localK] = tracker.LuaFunctions[localK] + 1

                -- call the old function
                return old(unpack(arg))
            end
        end
    end
end