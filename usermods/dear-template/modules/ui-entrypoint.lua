
--- Where all the magic happens. This file ensures that you can freely edit your 
-- UI without having the fear of crashing it. It relies on you having Diskwatch on,
-- if you do not have that enabled then the interactive approach to creating your
-- UI will not work.

-- To turn it on you must make /EnableDiskWatch a program argument of the game.

local function _CreateInterface(isReplay)

    -- Construct a window. You can construct multiple 
    -- windows as long as they have a unique title.
    local title = "template"
    local types = { "docked-left", "floating" }
    local type = types[1]
    local window = WindowConstruct(title, type)

    local function toDearWindowing()

        LOG("Template interface loop started!")

        -- the state of our error-less approach
        local ok = false 
        local message = ""
        local interfaceOld = nil
        local interface = nil

        while true do 

            -- how often we update the UI
            WaitSeconds(0.2)

            -- if we're hidden don't do anything
            if not window:IsHidden() then 

                -- we perform a safe call here. If anything goes wrong then the thread 
                -- this runs in will not crash. Instead the error will be caught!
                -- ok = true / false, message = nil / error
                ok, message = pcall (
                    function () 
                        -- load in the interface fresh in case it received an update from disk
                        interface = import("/mods/cinematics/modules/ui-view.lua")
                        interface.CreateInterface( window, isReplay) 
                    end
                )

                -- if the creating of the interface crashed then we'll do some additional steps
                if not ok then

                    -- if we didn't crash previously then we show the message as a warning. This 
                    -- prevents polluting the moho log with error messages.
                    if  (interfaceOld != interface) then 
                        WARN(message)            
                    end

                    -- we copy the reference of the interface. If we change the interface (by making
                    -- a change and reloading it) the reference will be different.
                    interfaceOld = interface
                else 
                    -- if we didn't crash, keep going
                    interfaceOld = nil
                end
            end
        end
    end

    -- run all of this in a separate thread
    ForkThread(toDearWindowing)
end

--- The entry point of the UI side of this mod, called in lua/ui/game/gamemain.lua
function Entrypoint(isReplay)

    ForkThread(
        function()

            -- we cannot fully rely on the game handling the mod ordering, hence we wait a bit to make sure
            -- that Dear Windowing is loaded in. Otherwise we go in empty handed :)

            local found = false
            local count = 10
            while count > 0 do 
                WaitSeconds(1.0)

                -- did we find it?
                found = _G.DearWindow and _G.DearWindowVersion
                if found then 

                    -- whoo! Start doing interface work
                    LOG("Found Dear Windowing version " .. tostring(_G.DearWindowVersion) .. "")
                    _CreateInterface(isReplay)
                    break
                end

                count = count - 1
            end

            -- woopsie, mod appears to be not there
            if not found then 
                WARN("Cannot initialize Cinematic: can not find Dear Windowing UI mod.")
            end
        end
    )
end