return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      isort = {
        prepend_args = { "--profile", "black" },
      },
      black = {
        prepend_args = {
          "--line-length",
          "100",
          "--skip-string-normalization",
        },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      python = { "isort", "black" },
      json = { "prettier" },
      jsonl = { "prettier" },
    },
  }
}