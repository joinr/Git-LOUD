
local baseOnSync = OnSync
function OnSync()
	baseOnSync()

    -- this is where we can receive data from the sim side of the game. On
    -- the sim side you can populate the global called Sync. It is a table
    -- that is sent to the UI side each tick.

    -- we can receive data from the sync by checking the data that we set
    if Sync.DataWeSet then 
        -- do something with that data
    end

    -- note that the Sync is cleared after each tick. If you wish to keep
    -- track of data you'll need to copy it over to a variable in your mod.

end 