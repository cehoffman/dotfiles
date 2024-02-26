local wezterm = require("wezterm")
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab. It prefers the title
-- that was set via `tab:set_title()` or `wezterm cli set-tab-title`, but falls
-- back to the title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

local function format_tab(wez_config)
	local scheme = wezterm.color.get_builtin_schemes()[wez_config.color_scheme]
	return function(tab, tabs, panes, config, hover, max_width)
		local num = string.format("%d:", tab.tab_index + 1)
		local title = string.sub(tab_title(tab), 1, max_width - 4 - #num)

		-- Determine what fg to use for left most tab left most arrow so it blends
		-- and doesn't draw as an arrow
		local function chomp_left_arrow(format)
			if tab.tab_index == 0 then
				table.remove(format, 1)
				table.remove(format, 1)
				table.remove(format, 1)
			end
			return format
		end

		if tab.is_active then
			-- Compute slightly dark active color and slightly brigher inactive color
			local h, s, l, a = wezterm.color.parse(scheme.foreground):hsla()
			local active_fg = wezterm.color.from_hsla(h, s, l * 0.8, a)
			return chomp_left_arrow({
				{ Foreground = { Color = scheme.tab_bar.background } },
				{ Background = { Color = active_fg } },
				{ Text = SOLID_RIGHT_ARROW },
				{ Background = { Color = active_fg } },
				{ Foreground = { Color = scheme.background } },
				{ Text = " " .. num .. title .. " " },
				{ Background = { Color = scheme.tab_bar.background } },
				{ Foreground = { Color = active_fg } },
				{ Text = SOLID_RIGHT_ARROW },
			})
		end
		local h, s, l, a = wezterm.color.parse(scheme.background):hsla()
		local inactive_fg = wezterm.color.from_hsla(h, s, l * 1.4, a)
		return chomp_left_arrow({
			{ Foreground = { Color = scheme.tab_bar.background } },
			{ Background = { Color = inactive_fg } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = inactive_fg } },
			{ Foreground = { Color = scheme.selection_fg } },
			{ Text = " " .. num .. title .. " " },
			{ Background = { Color = scheme.tab_bar.background } },
			{ Foreground = { Color = inactive_fg } },
			{ Text = SOLID_RIGHT_ARROW },
		})
	end
end

local function draw_usage(window, pane)
	local _, usage, _ =
		wezterm.run_child_process({ wezterm.home_dir .. "/.homebrew/bin/luajit", wezterm.home_dir .. "/.bin/usage" })
	window:set_right_status(usage)
end

return {
	config = function(config)
		config.use_fancy_tab_bar = false
		config.tab_max_width = 30
		config.tab_bar_at_bottom = true
		config.show_new_tab_button_in_tab_bar = false
		wezterm.on("format-tab-title", format_tab(config))

		wezterm.on("update-status", draw_usage)
		config.status_update_interval = 1000
	end,
}
