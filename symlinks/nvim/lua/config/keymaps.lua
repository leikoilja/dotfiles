-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map Enter in normal mode to search the word under cursor like `*`
vim.api.nvim_set_keymap("n", "<CR>", "*", { noremap = true, silent = true })
--
-- Clear selection with Ctrl-C in visual mode
vim.api.nvim_set_keymap("v", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- Optionally also map it in normal mode to act like Escape
vim.api.nvim_set_keymap("n", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- Map <leader>s p to fzf-lua grep_project
vim.api.nvim_set_keymap(
  "n",
  "<leader>sp",
  "<cmd>lua require('fzf-lua').grep_project()<CR>",
  { noremap = true, silent = true, desc = "Grep Project" }
)

-- Map <leader>s b to fzf-lua buffers
vim.api.nvim_set_keymap(
  "n",
  "<leader>bb",
  "<cmd>lua require('fzf-lua').buffers()<CR>",
  { noremap = true, silent = true, desc = "Buffer Selection" }
)

-- Map <leader>w to save the file
vim.api.nvim_set_keymap("n", "<leader>ww", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })