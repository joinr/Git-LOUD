

import("/lua/lazyvar.lua").ExtendedErrorMessages = true

local baseCreateUI = CreateUI;
function CreateUI(isReplay)

  -- similar to hook/lua/siminit.lua
  -- initialize our own ui elements
  LOG("<DearWindowing>loading DearWindowing")

  local path = "dear-windowing";
  import('/mods/' .. path .. '/modules/ui-entrypoint.lua').Entrypoint(isReplay)

  LOG("<DearWindowing> LOADED!")
  baseCreateUI(isReplay)
end
