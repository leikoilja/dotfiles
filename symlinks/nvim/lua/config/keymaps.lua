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


-- Map <leader>go to create a pull request
vim.api.nvim_set_keymap("n", "<leader>go", ":Octo pr create<CR>", { noremap = true, silent = true, desc = "Create a PR" })

vim.api.nvim_set_keymap("n", "<leader>gO", ":Octo pr browser<CR>", { noremap = true, silent = true, desc = "Open PR in browser" })

-- Flash navigation
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true, desc = "Flash Jump" })
vim.api.nvim_set_keymap("n", "S", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true, silent = true, desc = "Flash Treesitter" })

-- Reset s to default
vim.api.nvim_set_keymap("n", "s", "s", { noremap = true, silent = true, desc = "s" })

-- Sort selection
vim.api.nvim_set_keymap("v", "<leader>S", ":sort <CR>", { noremap = true, silent = true, desc = "Sort selection" })

-- Terminal
vim.api.nvim_set_keymap("n", "<leader>tt", ':lua require"utils".JBLRunCurrentTest("one")<cr>', { noremap = true, silent = true, desc = "Run current test (one)" })
vim.api.nvim_set_keymap("n", "<leader>tr", [[:<C-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>]], { noremap = true, silent = true, desc = "Rerun last command" })
vim.api.nvim_set_keymap("n", "<leader>tl", ":<C-u>exec v:count.'Tclear'<CR>", { noremap = true, silent = true, desc = "Clear terminal" })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- Set your custom keybinding for saving the file
-- vim.keymap.del("n", "<leader>w")
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })