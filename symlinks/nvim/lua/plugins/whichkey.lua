return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, noremap = true, silent = true },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, noremap = true, silent = true },
      { "<leader>ag", "<cmd>CodeCompanionChat Add<cr>", mode = "v", noremap = true, silent = true },
      { "<leader>ac", "<cmd>CodeCompanion<cr>", mode = "v", noremap = true, silent = true },
    },
  },
}