return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      bullet = {
        left_pad = 1,
        right_pad = 1,
      },
      heading = {
        width = "block",
        boarder = true,
        border_virtual = true,
        left_margin = 0.5,
        left_pad = 0.5,
        right_pad = 0.5,
      },
    })
  end,
}
