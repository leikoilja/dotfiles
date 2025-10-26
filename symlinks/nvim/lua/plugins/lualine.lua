return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      -- icons_enabled = true,
      -- theme = "gruvbox",
      -- section_separators = { left = "", right = "" },
      -- component_separators = { left = "", right = "" },
      disabled_filetypes = {},
      theme = {
        normal = {
          a = { fg = "#1e1e1e", bg = "#ffb86c" }, -- soft orange
          b = { fg = "#f0f0f0", bg = "#3a3a3a" }, -- soft medium gray
          c = { fg = "#e0e0e0", bg = "#2b2b2b" }, -- softer dark gray
        },
        insert = { a = { fg = "#1e1e1e", bg = "#8be9fd" } },
        visual = { a = { fg = "#1e1e1e", bg = "#bd93f9" } },
        replace = { a = { fg = "#1e1e1e", bg = "#ff5555" } },
        command = { a = { fg = "#1e1e1e", bg = "#ffb86c" } },
        terminal = { a = { fg = "#1e1e1e", bg = "#50fa7b" } },
      },
    },
    sections = {
      lualine_a = { "mode", "swenv" },
      lualine_b = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_c = {
        "lsp_progress",
        {
          function()
            return " "
          end,
          color = function()
            local status = require("sidekick.status").get()
            if status then
              return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
            end
          end,
          cond = function()
            local status = require("sidekick.status")
            return status.get() ~= nil
          end,
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        "encoding",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_c = {},
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  },
}
