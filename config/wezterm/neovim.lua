local wezterm = require("wezterm")

local function is_inside_vim(win, pane)
	-- tty will be nil if the pane is from a mux session
	local tty = pane:get_tty_name()
	if tty == nil then
		-- Work with the pane title to compute as we don't have direct access to
		-- the hardware context of the program being run
		local title = pane:get_title()
		return string.find(title, "^g?l?n?vim?x?") == 1
			or string.find(title, "^g?l?n?vim?x?diff") == 1
			or string.find(title, "^g?viewdiff") == 1
			or string.find(title, "^viewdiff") == 1
			or string.find(title, "- N?VIM$") ~= nil
	else
		local success, stdout, stderr = wezterm.run_child_process({
			"sh",
			"-c",
			"ps -o state= -o comm= -t"
				.. wezterm.shell_quote_arg(tty)
				.. " | "
				.. "grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'",
		})

		return success
	end
end

local function is_outside_vim(win, pane)
	return not is_inside_vim(win, pane)
end

local function bind_if(cond, key, mods, action)
	local function callback(win, pane)
		if cond(win, pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(wezterm.action.SendKey({ key = key, mods = mods }), pane)
		end
	end

	return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

-- Integrate with ZenMode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return {
	bind_if(is_outside_vim, "j", "CTRL", wezterm.action.ActivatePaneDirection("Down")),
	bind_if(is_outside_vim, "k", "CTRL", wezterm.action.ActivatePaneDirection("Up")),
	bind_if(is_outside_vim, "h", "CTRL", wezterm.action.ActivatePaneDirection("Left")),
	bind_if(is_outside_vim, "l", "CTRL", wezterm.action.ActivatePaneDirection("Right")),
}
