
local UIUtil = import('/lua/ui/uiutil.lua')

local baseCreateUI = CreateUI;
function CreateUI(isReplay)
  LOG("<PROFILER>: ---------------------LOADING PROFILER----------------")
	baseCreateUI(isReplay)
	-- similar to hook/lua/siminit.lua
	-- initialize our own ui elements

	ForkThread(
		function()
			import('/mods/profiler/modules/entrypoint.lua').Entrypoint(isReplay)
		end
	);

end
