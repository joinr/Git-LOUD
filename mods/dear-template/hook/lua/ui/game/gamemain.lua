
local UIUtil = import('/lua/ui/uiutil.lua')
-- import("/lua/lazyvar.lua").ExtendedErrorMessages = true

local baseCreateUI = CreateUI;
function CreateUI(isReplay) 
	baseCreateUI(isReplay) 

	LOG("Hooked gamemain.lua")

	-- similar to hook/lua/siminit.lua
	-- initialize our own ui elements

	-- allow us to hook our own quick dialog, we can not hook UIUtil as it is already loaded
	-- when the game launches.
	UIUtil.OldQuickDialog = UIUtil.QuickDialog
	UIUtil.QuickDialog = function( parent, dialogText, button1Text, button1Callback, button2Text, button2Callback, button3Text, button3Callback, destroyOnCallback, modalInfo )

		-- we can't see a dialog when the ui is toggled off
		local uiModel = import("/mods/cinematics/modules/ui-model.lua")
		if not uiModel.ConRenderUI then 
			uiModel.ConRenderUI = true 
			ConExecute("ren_UI true")
		end

		return UIUtil.OldQuickDialog( parent, dialogText, button1Text, button1Callback, button2Text, button2Callback, button3Text, button3Callback, destroyOnCallback, modalInfo  )
	end

	ForkThread(
		function()
			local path = "cinematics";
			import('/mods/' .. path .. '/modules/hotkeys.lua').CreateHotkeys(isReplay)
			import('/mods/' .. path .. '/modules/ui-entrypoint.lua').Entrypoint(isReplay)
		end
	);

end