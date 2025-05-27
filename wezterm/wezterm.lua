local wezterm = require("wezterm")
local wez = wezterm
local config = wezterm.config_builder()
local act = wezterm.action
--local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
--bar.apply_to_config(config, {
--	position = "bottom",
--	max_width = 32,
--	padding = {
--		left = 1,
--		right = 1,
--	},
--	separator = {
--		space = 1,
--		left_icon = "",
--		right_icon = ">",
--		field_icon = wez.nerdfonts.indent_line,
--	},
--	modules = {
--		tabs = {
--			active_tab_fg = 4,
--			inactive_tab_fg = 6,
--		},
--		workspace = {
--			enabled = true,
--			icon = wez.nerdfonts.cod_window,
--			color = 8,
--		},
--		leader = {
--			enabled = true,
--			icon = wez.nerdfonts.oct_rocket,
--			color = 2,
--		},
--		pane = {
--			enabled = true,
--			icon = wez.nerdfonts.cod_multiple_windows,
--			color = 7,
--		},
--		username = {
--			enabled = false,
--			icon = "",
--			color = 6,
--		},
--		hostname = {
--			enabled = true,
--			icon = wez.nerdfonts.cod_server,
--			color = 8,
--		},
--		clock = {
--			enabled = false,
--			icon = wez.nerdfonts.fa_clock,
--			color = 4,
--		},
--		cwd = {
--			enabled = true,
--			icon = "",
--			color = 7,
--		},
--	},
--})
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.7
config.macos_window_background_blur = 10

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "H",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "t",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

config.color_scheme = "Belge (terminal.sexy)"
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"FiraMono Nerd Font",
})
config.font_size = 12.5

return config
