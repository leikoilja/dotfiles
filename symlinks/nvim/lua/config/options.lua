-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Automatic toggling between line number based on the mode
vim.cmd("augroup numbertoggle")
vim.cmd("autocmd!")
vim.cmd("autocmd BufEnter,FocusGained,InsertLeave * set relativenumber")
vim.cmd("autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber")
vim.cmd("augroup END")

vim.g.lazyvim_picker = "fzf"

-- This disables showing of the blame text next to the cursor
vim.g.gitblame_display_virtual_text = 0

-- text wrapping
vim.opt.wrap = true

-- Autocmd to run isort on save for Python files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    require("conform").format({ formatters = { "isort" }})
  end,
})

-- format on save
vim.g.autoformat = false

--format on save tsx files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*ts", "*.tsx", "*.json", "*.jsonl" },
  callback = function()
    require("conform").format({ formatters = { "prettier" }})
  end,
})

-- -- Prevent stripping EOL on save
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufWritePost" }, {
--   group = "_formatting",
--   pattern = "*",
--   command = "setl fixeol"
-- })

-- Folding
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = ""

-- Neoterm
vim.g.neoterm_default_mod = "vertical"
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_automap_keys = 0
vim.g.neoterm_auto_repl_cmd = 0

vim.g.lazyvim_check_order = false