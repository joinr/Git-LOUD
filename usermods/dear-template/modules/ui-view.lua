
--- This file represents the View part of the MVC (Model / View / Controller) principle.
-- The purpose of this file is to visualize the model. Interacting with the model should be
-- limited as that is the job of the controller. Never the less, some interactions go
-- through the UI directly therefore it can not be completely prevented at times.

function CreateInterface(window, isReplay)
    -- we load in the model each frame to make sure we have the latest version
    local uiModel = import("/mods/cinematics/modules/ui-model.lua")
    
    -- tells the library to prepare for a new frame
    window:Begin()

    -- a basic UI element
    window:Text("Hello, Dear Windowing!")

    -- tells the library that we're done defining a frame, allowing it to clean up
    window:End()
end
