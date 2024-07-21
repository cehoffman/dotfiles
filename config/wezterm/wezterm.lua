local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- domains don't work well with semantic prompts or other terminal OSC features
-- https://github.com/wez/wezterm/issues/2880
-- https://github.com/wez/wezterm/issues/3987
config.unix_domains = {
	{
		name = "session",
	},
}
config.leader = { key = "`", timeout_milliseconds = 1000 }
config.keys = {
	-- Create a New Tab
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
	},
	-- Create a new split below
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Craete a new split to the right
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Send the leaer key through when in leader mode
	{ key = "`", mods = "LEADER", action = wezterm.action.SendKey({ key = "`" }) },
	-- Enter copy selection mode
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	-- Semantic prompt searching
	{ key = "UpArrow", action = wezterm.action.ScrollToPrompt(-1) },
	{ key = "DownArrow", action = wezterm.action.ScrollToPrompt(1) },
}

-- Adjust the copy mode key bindings
if wezterm.gui then
	local default_tables = wezterm.gui.default_key_tables()

	-- Make it possible to exit copy mode with the escape key mapping from ^[
	table.insert(default_tables.copy_mode, { key = "[", mods = "CTRL", action = wezterm.action.CopyMode("Close") })
	table.insert(default_tables.copy_mode, { key = "Enter", action = wezterm.action.CopyMode("Close") })
	table.insert(default_tables.copy_mode, { key = "i", action = wezterm.action.CopyMode("Close") })
	table.insert(
		default_tables.copy_mode,
		{ key = "/", action = wezterm.action.Search("CurrentSelectionOrEmptyString") }
	)
	table.insert(
		default_tables.copy_mode,
		{ key = "?", action = wezterm.action.Search("CurrentSelectionOrEmptyString") }
	)
	table.insert(default_tables.search_mode, { key = "[", mods = "CTRL", action = wezterm.action.CopyMode("Close") })

	config.key_tables = {
		copy_mode = default_tables.copy_mode,
		search_mode = default_tables.search_mode,
	}
end

-- Insert bindings to selection tab using leader and 1 through 9 number
for i = 1, 9 do
	--  + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

local neovim = require("neovim")
for _, key in ipairs(neovim) do
	table.insert(config.keys, key)
end

config.mouse_bindings = {
	{
		event = { Down = { streak = 4, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
	},
}

-- config.default_gui_startup_args = { "connect", "session" }
config.color_scheme = "Tokyo Night Moon"
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Geist Mono",
	-- "Meslo LG S", This display the word config terribly. Don't understand why
})
config.font_size = 9.0
config.window_decorations = "RESIZE"
config.mouse_wheel_scrolls_tabs = false
config.scrollback_lines = 10000
config.native_macos_fullscreen_mode = true

require("tabbar").config(config)

return config
