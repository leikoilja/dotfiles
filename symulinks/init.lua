require('plugins')

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true

-- keybindings
local map = require("utils").map
local JBLRunCurrentTest = require("utils").JBLRunCurrentTest

vim.g.mapleader = ","

-- map("n", ",<Space>", ":nohlsearch<CR>", { silent = true })
-- map("n", "<Leader>", ":<C-u>WhichKey ','<CR>", { silent = true })
-- map("n", "<Leader>?", ":WhichKey ','<CR>")
-- map("n", "<Leader>a", ":cclose<CR>")

-- Telescope search
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fF', builtin.find_files, {})
vim.keymap.set('n', '<leader>sp', builtin.live_grep, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

-- Switch vim tabs
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('i', '<leader><leader>', '<Esc>', {})
-- close all windows except current
vim.keymap.set('n', '<leader>wo', ':only<CR>', {silent = true})

-- quick save
vim.api.nvim_set_keymap('n', '<Leader>ww', ':update<CR>', { noremap = true, silent = true })

-- quick filew reload
vim.api.nvim_set_keymap('n', '<Leader>we', ':e<CR>', { noremap = true, silent = true })

-- windows nagivation
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- line nagivation
vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true })

-- sort selection
vim.api.nvim_set_keymap('v', '<leader>S', ':sort <CR>', { noremap = true })

-- search and center the screen
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)

-- Hop (easymotion alternative)
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>HopChar2<CR>", {noremap=true})

--- Neoterm terminal wrapper
-- ,, in the terminal windows as Esc
vim.api.nvim_set_keymap('t', '<leader><leader>', '<C-\\><C-n>' , { silent = true })

-- Run the current test
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require"utils".JBLRunCurrentTest()<cr>' , { noremap = true })

-- Clear the terminal
vim.api.nvim_set_keymap('n', '<leader>tc', [[:<C-u>exec v:count .. 'Tclear'<cr>]] , {noremap = true, silent = true})

-- Send selected text to REPL
vim.api.nvim_set_keymap('v', '<leader>tss', '<Plug>(neoterm-repl-send)' , { noremap = true })

-- Rerun the last command
vim.api.nvim_set_keymap('n', '<leader>tl', [[:<C-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>]] , { noremap = true, silent = true })

-- Toggle diagnostics
vim.api.nvim_set_keymap('n', '<leader>xt', '<Plug>(toggle-lsp-diag)', { noremap = true })

-- File tree
local status, nvim_tree = pcall(require, "nvim-tree.api")
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { noremap = true })

-- Symbols outline (tagline)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>SymbolsOutline<CR>', { noremap = true })

-- settings

-- relative line numbers
vim.wo.number = true
vim.o.relativenumber = true

-- clipboard sharing with OS
vim.opt.clipboard = "unnamedplus"

-- commenter
require('nvim_comment').setup()

-- Run PackerCompile automatically when plugins file is changed
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- Lualine status bar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }, 'lsp_progress'},
    lualine_x = {
        {require('auto-session-library').current_session_name},
      { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
        hint = ' ' } },
      'encoding',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = { 'fugitive' }
}

-- LSP configurations
require("mason").setup()
require("mason-lspconfig").setup{  -- After changes, run :Mason to install
    ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "html",
        "lua_ls",
        "jsonls",
        "tsserver",
        "pyright",
        "pylsp",
        "tailwindcss",
        "terraformls",
        "angularls"
    }
}
require("mason-null-ls").setup({  -- After changes, run :Mason to install
    automatic_setup = true,
    ensure_installed = { "eslint", "eslint_d" }
})

require("mason").setup()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')

lspconfig.eslint.setup{}
lspconfig.pylsp.setup{}
lspconfig.pyright.setup{}
lspconfig.tailwindcss.setup {}

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- CMP completion plugin 
local status, cmp = pcall(require, "cmp")
if (not status) then return end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- TypeScript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- treesitter
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {"lua"},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "bash",
    "json",
    "json5",
    "latex",
    "yaml",
    "css",
    "html",
    "lua",
    "scss",
    "sql",
    "terraform",
    "python",
    "dockerfile",
    "graphql",
    "htmldjango",
    "javascript",
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

-- autotag and autopair
local status, autotag = pcall(require, "nvim-ts-autotag")
if (not status) then return end

autotag.setup({})

local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- telescope
local status, telescope = pcall(require, "telescope")
if (not status) then return end

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<C-h>"] = require('telescope.actions').select_horizontal,
        ["<C-v>"] = require('telescope.actions').select_vertical,
      },
	n = {

        ["<C-c>"] = require('telescope.actions').close,
      }
    }
  },
    pickers = {
        find_files = {
            hidden = true
        }
    },
extensions = {
	undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
          mappings = {
            i = {
              -- ["<C-y>"] = require("telescope-undo.actions").yank_additions,
              -- ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
            ["<CR>"] = require("telescope-undo.actions").restore,
          },
        }
    }
}}
telescope.load_extension "undo"

-- bufferline
require("bufferline").setup{
	options ={
		mode ="tabs",
		show_buffer_close_icons = false
	}
}

-- enable auto-indentation
vim.o.autoindent = true

-- replace tabs with spaces
vim.o.expandtab = true

-- set tab width to 4 spaces
vim.o.tabstop = 4

-- set indentation width to 4 spaces
vim.o.shiftwidth = 4

-- Git Signs
local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup()

-- null-ls
local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  }
})

-- prettier
local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less"
  }
}

-- Toggle diagnostics
require('toggle_lsp_diagnostics').init()

-- Whichkey mapping 
local wk = require("which-key")

wk.register({
  f = {
    name = "file", -- optional group name
    f = { "Find git file" }, 
    F = { "Find file in the working directory" },
  },
  x = {
    name = "trouble", 
    t = { "Toggle diagnostics" },
  },
  t = {
    name = "terminal", 
    t = { "Extract and run JBL test under cursor" },
    c = { "Clear console" },
    l = { "Rerun last terminal command" },
    s = { 
        name = "Send",
        s = { "Send selected text to REPL" },
    },
  },
}, { prefix = "<leader>" })


-- Neoterm
vim.g.neoterm_default_mod = "vertical"
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_automap_keys = 0
vim.g.neoterm_auto_repl_cmd = 0

-- Hop
require'hop'.setup {
    case_insensitive = true,
    multi_windows = true,
}

-- Automatic toggling between line number modes
vim.cmd('augroup numbertoggle')
vim.cmd('autocmd!')
vim.cmd('autocmd BufEnter,FocusGained,InsertLeave * set relativenumber')
vim.cmd('autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber')
vim.cmd('augroup END')

-- Display invisible characters
vim.opt.listchars = {tab = '> ', trail = '•', extends = '>', precedes = '<',nbsp = '+'}
vim.opt.list = true   

-- Enable smartcase (needs ignorecase) - lower finds all / upper finds exact
-- Enable incremental search to see matches as we type
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- file tree
require("nvim-tree").setup {}

-- outline (tagbar alternative)
require("symbols-outline").setup {
    highlight_hovered_item = false,
    show_relative_numbers = true,
    symbol_blacklist = {
      -- 'File',
      -- 'Module',
      -- 'Namespace',
      'Package',
      -- 'Class',
      -- 'Method',
      'Property',
      'Field',
      'Constructor',
      'Enum',
      -- 'Interface',
      -- 'Function',
      'Variable',
      'Constant',
      'String',
      'Number',
      'Boolean',
      'Array',
      'Object',
      'Key',
      'Null',
      'EnumMember',
      -- 'Struct',
      'Event',
      'Operator',
      'TypeParameter',
      -- 'Component',
      'Fragment',
    },
}

-- alpha dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.footer.val = require'alpha.fortune'()
alpha.setup(dashboard.opts)

-- Set header
dashboard.section.header.val = {
"",
" ░█████╗░██████╗░███████╗░█████╗░████████╗███████╗ ",
" ██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝ ",
" ██║░░╚═╝██████╔╝█████╗░░███████║░░░██║░░░█████╗░░ ",
" ██║░░██╗██╔══██╗██╔══╝░░██╔══██║░░░██║░░░██╔══╝░░ ",
" ╚█████╔╝██║░░██║███████╗██║░░██║░░░██║░░░███████╗ ",
" ░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝ ",
"",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd ~/Development | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

-- Auto session
require("auto-session").setup {
    log_level = "error",

  cwd_change_handling = {
    restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"


-- neogit
local neogit = require('neogit')

neogit.setup {
    integrations = {
        diffview = true
    }
}

-- kanagawas theme
require('kanagawa').setup({
    overrides = function(colors)
        local theme = colors.theme
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Block-like modern Telescope UI
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            -- Dark completion (popup) menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
        }
    end,
})


-- Theme setup
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme kanagawa-dragon")
