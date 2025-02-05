return {
  "MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      enabled = true,
      bullet = {
        left_pad = 1,
        right_pad = 1,
      },
      heading = {
        enabled = true,
        icons = {},
        backgrounds = {
          "GruvboxYellow",
          "GruvboxOrange",
          "GruvboxPurple",
          "GruvboxPurple",
          "GruvboxPurple",
          "GruvboxPurple",
        },
      },
      win_options = {
        conceallevel = { default = 0, rendered = 0 },
      },
    })
  end,
}
