-- This file configures the codecompanion.nvim plugin for Neovim
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    -- Required dependencies
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Optional dependency for rendering markdown
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  config = true, -- Enable automatic configuration
  opts = {
    strategies = {
      chat = {
        adapter = "copilot", -- Use copilot adapter for chat
      },
      inline = {
        adapter = "copilot", -- Use copilot adapter for inline suggestions
      },
    },
  },
}