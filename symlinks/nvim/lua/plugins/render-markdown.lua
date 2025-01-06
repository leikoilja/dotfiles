return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      bullet = {
        left_pad = 1,
        right_pad = 1,
      },
    })
  end,
}