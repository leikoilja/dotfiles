return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", "/Users/leikoilja/Development/dotfiles/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}