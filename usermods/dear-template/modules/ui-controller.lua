
--- This file represents the Controller part of the MVC (Model / View / Controller) principle.
-- The purpose of this file is to make adjustments to the model. It should at no point interfere
-- with the view directly. Examples are hotkey functionality, or a loop that checks information.

-- For more information about sending data to the sim look at the file hook/lua/UserSync.lua.

--- A basic test to show how hotkeys work
function HotkeyTesting()
    -- we load in the model in each function to make sure we have the latest
    local uiModel = import("/mods/cinematics/modules/ui-model.lua")

    LOG("We did a hotkey thing!")
end
