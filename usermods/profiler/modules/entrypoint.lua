
local function _CreateInterface(isReplay)
    LOG("<PROFILER>:--------CREATING INTERFACE------------")
    --- Hot reloads
    local function toDearWindowing(window, view, ...)

        local ok = false 
        local message = ""
        local interfaceOld = nil
        local interface = nil

        while true do 

            WaitSeconds(0.1)

            -- import it every loop to allow re-loading the file
            if not window:IsHidden() then 

                -- perform a safe call
                ok, message = pcall (
                    function () 
                        -- load in interface to receive updates
                        interface = import(view)
                        interface.CreateInterface( window, isReplay, unpack(arg))
                    end
                )

                -- if we not ok and the interface is different then we warn us with the message
                if not ok then

                    -- first time crash, tell us what went wrong
                    if  (interfaceOld != interface) then 
                        WARN(message)            
                    end

                    -- keep track of changes
                    interfaceOld = interface
                else 
                    -- if we didn't crash, keep going
                    interfaceOld= nil
                end
            end
        end
    end 

    --- Scans continiously for new windows.
    local function scanForNewWindows()

        local knownWindows = { }
        local tView = "/mods/profiler/modules/views/table.lua"
        local cView = "/mods/profiler/modules/views/class.lua"

        -- Scan for entries that we didn't see before and creates the window accordingly
        local function Scan(elements, view)
            for k, element in elements do 
                if not knownWindows[k] then 

                    LOG("Found profile data for identifier: " .. k)

                    local window = WindowConstruct("Profiler - " .. k, "floating", 400, 400)
                    window:Hide()
                    ForkThread(toDearWindowing, window, view, k)
                    knownWindows[k] = true 

                    local model = import("/mods/profiler/modules/model.lua")
                    model.WindowData[k] = { 
                          Identifier = k
                        , Window = window 
                        , Shown = false
                    }
                end
            end
        end

        -- Continiously scan for new entries
        while true do 
            WaitSeconds(0.5)
            local model = import("/mods/profiler/modules/model.lua")
            Scan(model.TableCounters, tView)
            Scan(model.ClassCounters, cView)
        end
    end

    -- Construct and visualize the main window
    local wMain = WindowConstruct("Profiler", "docked-left", 450, 700)
    ForkThread(toDearWindowing, wMain, "/mods/profiler/modules/views/main.lua")

    -- Scan continiously for other windows
    ForkThread(scanForNewWindows)
end

function Entrypoint(isReplay)
  LOG("<Profiler>:------------------Begin EntryPoint!-------------------")
    ForkThread(
        function()

            -- we cannot fully rely on the game handling the mod ordering, hence we wait a bit to make sure
            -- that Dear Windowing is loaded in. Otherwise we go in empty handed :)

            LOG("<PROFILER>:----------LOOKING FOR DearWindowing----------------->")
            local found = false
            local count = 10
            while count > 0 do
                WaitSeconds(1.0)

                -- are we there yet?
                found = _G.DearWindow and _G.DearWindowVersion
                if found then 
                    LOG("Found Dear Windowing version (" .. tostring(_G.DearWindowVersion) .. ")")
                    _CreateInterface(isReplay)
                    break
                end

                count = count - 1
            end

            -- woopsie
            if not found then 
                WARN("Cannot initialize Profiler: can not find Dear Windowing UI mod.")
            end
        end
    )
end
