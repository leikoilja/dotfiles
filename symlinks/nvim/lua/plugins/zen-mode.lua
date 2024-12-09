return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.85, -- width will be 85% of the editor width
        backdrop = 1, -- enable the backdrop
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = true, -- enable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        kitty = { enabled = false }, -- disables kitty statusline
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}