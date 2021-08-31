
function SetupSession()

    -- ?

end

function BeginSession()
  LOG("<PROFILER>----------BeginSession--------------")
    ForkThread(
        function()

            -- Wait for hard-hooks to pass
            WaitSeconds(1.0)
            
            -- Gather information to soft-hook
            local hook = import("/mods/profiler/modules/sim/hooks/table.lua").Hook
            local tables = import("/mods/profiler/config.lua").TableHooks
            local exceptions = { import = true, _G = true }

            -- Soft-hook them all!
            for k, t in tables do 
                hook(t.Identifier, t.Table, exceptions )
            end

            -- Sync the profiler information to the UI
            while true do 
                WaitSeconds(0.2)
                local controller = import("/mods/profiler/modules/sim/controller.lua")
                controller.ToSync()
            end
        end
    )
end
