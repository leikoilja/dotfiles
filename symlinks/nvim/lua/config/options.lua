-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- remap leader key
vim.g.mapleader = ","

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
  pattern = "*.tsx",
  callback = function()
    require("conform").format({ formatters = { "prettier" }})
  end,
})

-- Disable automatic newline at the end of file
vim.opt.fixeol = false
vim.opt.endofline = false