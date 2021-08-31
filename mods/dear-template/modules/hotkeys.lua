


function CreateHotkeys()

	local uiModel = import("/mods/cinematics/modules/ui-model.lua")

	-- construct the keybindings
	local newKeyBindings = { }
	for k, hotkey in uiModel.HotkeysGeneral do 
		newKeyBindings[hotkey.Keys] = { action = hotkey.Func }
	end

	for k, hotkey in uiModel.HotkeysMoveTo do 
		newKeyBindings[hotkey.Keys] = { action = hotkey.Func }
	end

	for k, hotkey in uiModel.HotkeysSpin do 
		newKeyBindings[hotkey.Keys] = { action = hotkey.Func }
	end

    -- Add the new keybindings.
    IN_AddKeyMapTable(newKeyBindings)
end