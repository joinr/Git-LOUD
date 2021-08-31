
local Info = import("/mods/dear-windowing/mod_info.lua")
local Window = import("/mods/dear-windowing/modules/window.lua")

function Entrypoint(isReplay)

    LOG("<DearWindowing>------UI ENTRYPOINT------------")
    -- populate the global scope
    _G.WindowConstruct = Window.WindowConstruct
    _G.WindowDeconstruct = Window.WindowDeconstruct
    _G.WindowGet = Window.WindowGet
    _G.DearWindow = true
    _G.DearWindowVersion = Info.version

end
