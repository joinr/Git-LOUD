
profilerOnSync = OnSync
function OnSync()

    -- copy sync data if present
    if Sync.Profiler then 
        if Sync.Profiler.TableCounters then 
            import("/mods/profiler/modules/controller.lua").TableCountersFromSync(Sync.Profiler.TableCounters)
        end

        if Sync.Profiler.ClassCounters then 
            import("/mods/profiler/modules/controller.lua").ClassCountersFromSync(Sync.Profiler.ClassCounters)
        end

        if Sync.Profiler.Benchmarks then 
            import("/mods/profiler/modules/controller.lua").BenchmarksFromSync(Sync.Profiler.Benchmarks)
        end    
    end

    profilerOnSync()
end