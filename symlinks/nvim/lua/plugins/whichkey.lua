return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>w", proxy = false },

      { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, noremap = true, silent = true },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, noremap = true, silent = true },
      { "<leader>ag", "<cmd>CodeCompanionChat Add<cr>", mode = "v", noremap = true, silent = true },
      { "<leader>ac", "<cmd>CodeCompanion Inline Assistant<cr>", mode = "v", noremap = true, silent = true },
    },
  },
}