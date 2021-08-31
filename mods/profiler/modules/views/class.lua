
local conversion = import("/mods/dear-windowing/modules/conversion.lua")

function CreateInterface(window, isReplay, identifier)

    local percentage = 0.9

    local function CreateSortedHeaderList(identifier, elements)
        if window:BeginCollapsingHeader(identifier) then 

            -- make each profiled function part of a list
            local height = 400

            local count = table.getsize(elements)
            if count > 0 then 

                window:BeginList(identifier .. "-meta-list", math.min(400, count * 15))

                -- Get all the keys
                local count = 1
                local sorted = { }
                for k, _ in elements do 
                    sorted[count] = k 
                    count = count + 1
                end

                -- Sort them all
                table.sort(sorted)

                -- create text elements with dividers
                local dividerCount = 0
                for k = 1, count - 1 do 

                    -- make text element
                    local id = sorted[k]
                    local counter = elements[id]
                    window:TextWithLabel(tostring(id), tostring(counter), percentage)

                    -- make divider
                    dividerCount = dividerCount + 1
                    if dividerCount > 9 then 
                        window:Divider()
                        dividerCount = dividerCount - 10
                    end
                end

                window:EndList(identifier .. "-meta-list")
            else 
                window:Text("Nothing to show!")
            end
        end

        window:EndCollapsingHeader(identifier)
    end

    -- Get the data
    local genModel = import("/mods/profiler/modules/model.lua")
    local profileData = genModel.ClassCounters[identifier]

    window:Begin()

        -- Show the data
        CreateSortedHeaderList("Moho functions", profileData.EngineFunctions)
        CreateSortedHeaderList("Lua functions", profileData.LuaFunctions)

    window:End()
end
