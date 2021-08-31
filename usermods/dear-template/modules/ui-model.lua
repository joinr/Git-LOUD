
--- This file represents the Model part of the MVC (Model / View / Controller) principle.
-- The purpose of this file is to keep track of information that we want to display on
-- the UI. It can be anything, and typically it is provided by data send from the sim. 

-- For more information about sending data to the sim look at the file hook/lua/UserSync.lua.

-- HOTKEYS --

-- Keeps track of all the hotkey information
Hotkeys = { }

--- Formats the hotkey entry.
local function CreateHotkey (keys, description, func)
    return { Keys = keys, Description = description, Func = func }
end

-- adds an entry to the hotkeys table for use
table.insert(Hotkeys, CreateHotkey(
        "Ctrl-1", 
        "Run test 1", 
        'UI_Lua import("/mods/cinematics/modules/ui-controller.lua").ToggleReset()'
    )
)