return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
                             [@leikoilja]
    ]]
    dashboard.section.header.val = vim.split(logo, "\n")
  end,
}