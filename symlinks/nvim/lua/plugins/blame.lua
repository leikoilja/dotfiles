return {
  "FabijanZulj/blame.nvim",
  cmd = { "BlameToggle" },
  config = function(_, opts)
    require("blame").setup(opts)
  end,
  opts = {},
}
