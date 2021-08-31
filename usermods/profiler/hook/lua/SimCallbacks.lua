
local RunIndividualBenchmark = import("/mods/profiler/modules/benchmarking/controller.lua").RunIndividualBenchmark

Callbacks.RunBenchmark = function(data)
    RunIndividualBenchmark(data.File, data.Func)
end
