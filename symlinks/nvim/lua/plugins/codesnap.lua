return {
  {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0",
    opts = {
      snapshot_config = {
        watermark = {
          content = "CodeSnap.nvim",
          font_family = "Pacifico",
          color = "#ffffff",
        },
        code_config = {
          breadcrumbs = {
            enable = true,
            separator = "/",
            color = "#80848b",
            font_family = "CaskaydiaCove Nerd Font",
          },
        },
        show_line_number = true,
      },
    },
  },
}