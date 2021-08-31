
local ProfilerUtils = import("/mods/profiler/modules/utils.lua")

--- Retrieves the data from the sim model and sends them to the sync for UI visualisation.
function ToSync()

    -- get the model to read from
    local simModel = import("/mods/profiler/modules/sim/model.lua")

    -- prepare sync table
    Sync.Profiler = Sync.Profiler or { }
    Sync.Profiler.TableCounters = ProfilerUtils.DeepCopy(simModel.TableCounters)
    Sync.Profiler.ClassCounters = ProfilerUtils.DeepCopy(simModel.ClassCounters)

end