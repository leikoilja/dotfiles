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