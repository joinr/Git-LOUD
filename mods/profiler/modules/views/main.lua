
function CreateInterface(window, isReplay)

    local genModel = import("/mods/profiler/modules/model.lua")
    local genController = import("/mods/profiler/modules/controller.lua")

    local function CreateWindowCheckbox(identifier, windowData)
        -- create a checkbox for showing it
        local wData = genModel.WindowData[identifier]
        wData.Shown, interacted = window:Checkbox("Show " .. identifier .. " profiler window", wData.Shown)

        -- if interacted, adjust visibility
        if interacted then 
            genController.AdjustVisibilityWindow(identifier) 
        end 
    end

    local percentage = 0.9

    window:Begin()

        window:Space()

        window:BeginTabBar("main-tabs", { "General", "Timers", "Stamps", "Benching" } )

            window:Space()

            if window:BeginTab("General") then 

                -- if true then the checkbox got interacted with
                local interacted = false

                window:Text("Profiled classes")
                window:Divider()
                window:Space()
                for k, element in genModel.ClassCounters do 
                    -- only show the window when it is ready
                    if genModel.WindowData[k] then 
                        CreateWindowCheckbox(k)
                    end
                end

                window:Text("Profiled tables")
                window:Divider()
                window:Space()
                for k, element in genModel.TableCounters do 
                    -- only show the window when it is ready
                    if genModel.WindowData[k] then 
                        CreateWindowCheckbox(k, element)
                    end
                end
            end

            if window:BeginTab("Timers") then 
                window:Text("Shows all timers")
            end

            if window:BeginTab("Stamps") then 
                window:Text("Shows all cache differences")
            end

            if window:BeginTab("Benching") then 

                if table.getsize(genModel.Benchmarks) > 0 then 

                    -- sort it all on key
                    local sortedBenchmarkFiles = { }
                    for k, _ in genModel.Benchmarks do 
                        table.insert(sortedBenchmarkFiles, k)
                    end

                    table.sort(sortedBenchmarkFiles)

                    for k, fileID in sortedBenchmarkFiles do 
                        if window:BeginCollapsingHeader(fileID) then 

                            local benchmarkFile = genModel.Benchmarks[fileID]

                            -- sort it all on key
                            local sortedBenchmarks = { }
                            for k, _ in benchmarkFile do 
                                table.insert(sortedBenchmarks, k)
                            end

                            table.sort(sortedBenchmarks)

                            for l, functionID in sortedBenchmarks do 

                                local benchmark = benchmarkFile[functionID]

                                local identifier = functionID .. "#" .. k --  .. " - " .. tostring(benchmark.Time) .. "#" .. k
                                if window:BeginCollapsingHeader(identifier) then 
                                    window:TextWithLabel("Time (in seconds)", benchmark.Time, 0.35)
                                    window:TextWithLabel("Max stack", benchmark.MaxStack, 0.35)
                                    window:TextWithLabel("Num. of parameters", benchmark.NumParams, 0.35)
                                    window:Space()

                                    if window:Button("Rerun benchmark#" .. k .. l) then 
                                        genController.ReRunBenchmark(fileID, functionID)
                                    end

                                    if window:Button("Benchmark to moholog#" .. k .. l) then 
                                        genController.LogBenchmark(benchmark)
                                    end

                                    window:Space()

                                    window:Text("Lua machine code")
                                    window:Divider()
                                    window:Space()
                                    window:BeginList(identifier .. "list", 300)
                                        for m, code in benchmark.Code do 
                                            window:TextWithLabel(m, code, 0.3)
                                        end
                                    window:EndList(identifier .. "list")
                                end

                                window:EndCollapsingHeader(identifier)

                            end
                        end

                        window:EndCollapsingHeader(k)
                    end
                else 
                    window:Text("No benchmark data received!")
                end
            end

        window:EndTabBar("main-tabs")

    window:End()

end