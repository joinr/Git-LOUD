
-- Upvalue for performance
local GetSystemTimeSecondsOnlyForProfileUse = GetSystemTimeSecondsOnlyForProfileUse

-- Ensures warnings are only shown once
local SurpressWarnings = { }

-- Keeps track of the timers on the sim side.
local Timers = { }

--- Constructs a basic timer.
local function ConstructTimer()
    return {
        StartedAt = 0
    }
end

--- Creates a timer. The identifier must match future calls.
function StartTimer(identifier)
    local timer = Timers[identifier] or ConstructTimer()
    timer.StartedAt = GetSystemTimeSecondsOnlyForProfileUse()
    Timers[identifier] = timer 
end

--- Stops a timer. The identifier must match other calls.
function StopTimer(identifier)
    -- compute delta and add to total
    local timer = Timers[identifier]
    if timer and timer.StartedAt ~= 0then 
        -- get the current time and set that as the start time
        local time = GetSystemTimeSecondsOnlyForProfileUse()

        -- compute delta (difference between start and stop)
        local delta = time - timer.StartedAt

        -- send to UI
        Sync.Profiler = Sync.Profiler or { }
        Sync.Profiler.Timers = Sync.Profiler.Timers or { }
        Sync.Profiler.Timers[identifier] = delta
    else
        local idWarning = identifier .. "-getandstop"
        if not SurpressWarnings[identifier] then 
            WARN("Profiler - attempting to get and stop a timer that is paused or does not exist: " .. identifier .. ", further warnings for this timer are surpressed.")
            SurpressWarnings[identifier] = true 
        end
    end
end