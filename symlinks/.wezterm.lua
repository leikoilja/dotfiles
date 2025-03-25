local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- tmux configurations --
local tmux = {}
if wezterm.target_triple == "aarch64-apple-darwin" then
    tmux = { "/opt/homebrew/bin/tmux", "new", "-As--general--" }
else
    tmux = { "tmux", "new", "-As0" }
end

config.default_prog = tmux

-- appearance --
config.hide_tab_bar_if_only_one_tab = true
-- config.color_scheme = 'Afterglow (Gogh)'
-- config.color_scheme = 'Apprentice (Gogh)'
-- config.color_scheme = 'Sweet Love (terminal.sexy)'
config.color_scheme = 'Gruvbox Dark (Gogh)'

config.font = wezterm.font 'JetBrainsMono NF'

config.window_decorations = 'RESIZE'
config.max_fps=120

-- keybindings --
config.keys = {
    {
        key = 't',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01c"),  -- Send Ctrl+A followed by c to create a new tmux window
    },
    {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x78"),
    },
    -- Navigate to tmux window 1 with Cmd+1
    {
        key = '1',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x31"),  -- Send Ctrl+A followed by 1
    },
    -- Navigate to tmux window 2 with Cmd+2
    {
        key = '2',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x32"),  -- Send Ctrl+A followed by 2
    },
    -- Navigate to tmux window 3 with Cmd+3
    {
        key = '3',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x33"),  -- Send Ctrl+A followed by 3
    },
    -- Navigate to tmux window 4 with Cmd+4
    {
        key = '4',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x34"),  -- Send Ctrl+A followed by 4
    },
    -- Navigate to tmux window 5 with Cmd+5
    {
        key = '5',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x35"),  -- Send Ctrl+A followed by 5
    },
    -- Navigate to tmux window 6 with Cmd+6
    {
        key = '6',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x36"),  -- Send Ctrl+A followed by 6
    },
    -- Navigate to tmux window 7 with Cmd+7
    {
        key = '7',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x37"),  -- Send Ctrl+A followed by 7
    },
    -- Navigate to tmux window 8 with Cmd+8
    {
        key = '8',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x38"),  -- Send Ctrl+A followed by 8
    },
    -- Navigate to tmux window 9 with Cmd+9
    {
        key = '9',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x39"),  -- Send Ctrl+A followed by 9
    },
    -- Create a vertical split with Cmd+D
    {
        key = 'd',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x5f"),  -- Send Ctrl+A followed by _
    },
    -- Create a horizontal split with Cmd+S
    {
        key = 's',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x2d"),  -- Send Ctrl+A followed by -
    },
    -- Navigate left with Cmd+H
    {
        key = 'h',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x68"),  -- Send Ctrl+A followed by h
    },
    -- Navigate down with Cmd+J
    {
        key = 'j',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x6a"),  -- Send Ctrl+A followed by j
    },
    -- Navigate up with Cmd+K
    {
        key = 'k',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x6b"),  -- Send Ctrl+A followed by k
    },
    -- Navigate right with Cmd+L
    {
        key = 'l',
        mods = 'CMD',
        action = wezterm.action.SendString("\x01\x6c"),  -- Send Ctrl+A followed by l
    },
  }

-- debug keyboard presses (run wezterm from Terminal app to watch logs)
-- config.debug_key_events = true
return config