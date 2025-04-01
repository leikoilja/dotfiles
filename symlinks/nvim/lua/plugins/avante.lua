return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "copilot",
    auto_suggestions_provider = 'claude', -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider. auto_suggestions is turned off
    behaviour = {
      auto_suggestions = false,  -- for now useing copilot plugin directly
    },
    copilot = {
      endpoint = 'https://api.githubcopilot.com/',
      model = 'claude-3.7-sonnet',
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Do not allow insecure server connections
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0.1, -- kinda creative
      max_tokens = 8192,
    },
    windows = {
      position = 'right',
      width = 45, -- %
      ask = {
        start_insert=false
      }
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "echasnovski/mini.icons",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}