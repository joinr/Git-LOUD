
local ProfilerUtils = import("/mods/profiler/modules/utils.lua")

--- Retrieves the data from the Sync and sends them to the ui model.
function TableCountersFromSync(hooks)

    -- todo: overwrite table instead of making new table each time
    local genModel = import("/mods/profiler/modules/model.lua")
    genModel.TableCounters = ProfilerUtils.DeepCopy(hooks)
end

--- Retrieves the data from the Sync and sends them to the ui model.
function ClassCountersFromSync(hooks)

    -- todo: overwrite table instead of making new table each time
    local genModel = import("/mods/profiler/modules/model.lua")
    genModel.ClassCounters = ProfilerUtils.DeepCopy(hooks)
end

function BenchmarksFromSync(benchmarks)
    local genModel = import("/mods/profiler/modules/model.lua")

    -- if we didn't receive anything yet - then just deep-copy
    if not genModel.BenchmarksReceived then 
        genModel.Benchmarks = ProfilerUtils.DeepCopy(benchmarks)
        genModel.BenchmarksReceived = true 

    -- otherwise, we want to overwrite only
    else 
        for k, file in benchmarks do 
            for l, benchmark in file do 
                genModel.Benchmarks[k][l] = ProfilerUtils.DeepCopy(benchmark)
            end
        end
    end
end

--- Toggles the visibility of the window
function AdjustVisibilityWindow(identifier)
    local windows = import("/mods/profiler/modules/model.lua").WindowData
    -- show or hide it accordingly
    if windows[identifier].Shown then 
        LOG("Showing: " .. identifier)
        windows[identifier].Window:Show()
    else
        LOG("Hiding: " .. identifier)
        windows[identifier].Window:Hide()
    end
end

--- Runs a benchmark in the sim.
function ReRunBenchmark(file, func)
    SimCallback( {
        Func = "RunBenchmark",
        Args = {
            File = file,
            Func = func,
        }
    }, false)
end

--- Logs a benchmark to the moholog.
function LogBenchmark (benchmark)
    LOG(repr(benchmark))
end