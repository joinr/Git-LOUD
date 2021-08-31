LOG("<PROFILER>----------SimInit")
local profilerSetupSession = SetupSession
function SetupSession()
  import("/mods/profiler/modules/sim/entrypoint.lua").SetupSession()
  LOG("<PROFILER>----------StartupSession")
    return profilerSetupSession()
end

local profilerBeginSession = BeginSession
function BeginSession()
  LOG("<PROFILER>----------BeginSession")
    profilerBeginSession()
    import("/mods/profiler/modules/sim/entrypoint.lua").BeginSession()
    ForkThread(function()

        -- wait for loading interference to subsede
        WaitSeconds(2.0)
        import("/mods/profiler/modules/benchmarking/controller.lua").RunAllBenchmarks()
    end)
end
