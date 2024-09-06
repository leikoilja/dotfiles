require('plugins')

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- keybindings
local map = require("utils").map
local JBLRunCurrentTest = require("utils").JBLRunCurrentTest

local github = require("github")

vim.g.mapleader = ","

-- Telescope search
local builtin = require('telescope.builtin')

-- windows nagivation
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- line nagivation
vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true })

-- search and center the screen
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })

-- File tree
local status, nvim_tree = pcall(require, "nvim-tree.api")

-- search under cursor
vim.api.nvim_set_keymap('n', '<CR>', [[:let @/ = '\<<C-r><C-w>\>' | :set hlsearch<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':set invhlsearch<CR>', { noremap = true })

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
    lualine_b = {{
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }},
    lualine_c = { 'lsp_progress'},
    lualine_x = {
        -- {require('auto-session-library').current_session_name},
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
    lualine_b = {{
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- LSP configurations
require("mason").setup()
require("mason-lspconfig").setup{  -- After changes, run :Mason to install
    ensure_installed = {
        "angularls",
        "bashls",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "html",
        "jsonls",
        "lua_ls",
        "pylsp",
        "pyright",
        "tailwindcss",
        "terraformls",
        "tsserver",
    }
}
require("mason-null-ls").setup({  -- After changes, run :Mason to install
    automatic_setup = true,
    ensure_installed = { "eslint", "djlint", "mypy", 'isort' }
})

require("mason").setup()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')

lspconfig.eslint.setup{}
lspconfig.pylsp.setup{}
lspconfig.pyright.setup{}
lspconfig.tailwindcss.setup {}
lspconfig.terraformls.setup {}

-- lspkind vscode-like pictograms for LSP
local lspkind = require('lspkind')

-- Copilot
local status, copilot = pcall(require, "copilot")
if not status then return end

copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<C-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = { enabled = false },
  filetypes = {
    ['*'] = true,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})

-- CMP completion plugin
local status, cmp = pcall(require, "cmp")
if (not status) then return end

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50,
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      symbol_map = { Copilot = "" },
    })
  },
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
    ['<C-s>'] = cmp.mapping.complete({
        config = {
            sources = {
              { name = 'copilot' },
            }
          }
        }
    ),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'copilot' },
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
lspconfig.ts_ls.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
}

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

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
    vim.keymap.set('n', 'gi',vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<leader>xa',vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<leader>F', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

-- treesitter
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  auto_install = true,
  highlight = {
    enable = true,
    disable = {
      "lua",
      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1788#issuecomment-972764251
      "htmldjango",
    },
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "c",
    "css",
    "dockerfile",
    "graphql",
    "html",
    "htmldjango",
    "javascript",
    "json",
    "json5",
    "latex",
    "lua",
    "lua",
    "python",
    "query",
    "scss",
    "sql",
    "terraform",
    "toml",
    "tsx",
    "vim",
    "vimdoc",
    "yaml",
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

-- terminal image previewer
local img_previewer = { "chafa" }

-- fzf (real one)
local status, fzf_lua = pcall(require, "fzf-lua")
local actions = require "fzf-lua.actions"
fzf_lua.setup(
  {
    'telescope', -- set profile close to telescope in looks and feels
    actions = {
      files = {
          ['ctrl-s'] = actions.file_split,
          ['ctrl-v'] = actions.file_vsplit,
      },
      buffers = {
          ['ctrl-s'] = actions.buf_split,
          ['ctrl-v'] = actions.buf_vsplit,
      }
    },
    previewers = {
        builtin = {
          extensions = {
              ["gif"] = img_previewer,
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["svg"] = img_previewer,
          },
        }
    },
    lsp = {
        -- make lsp requests synchronous so they work with null-ls
        async_or_timeout = 3000,
    },
    builtin = {
      hl_cursorline = "Search", -- cursor line highlight
    },
    grep = {
      -- ignore directiries during fuzzy grep search
      -- note, specify using global .rgignore file
      -- rg_opts = "-g '!{.git,node_modules}/' --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    }
  }
)

-- telescope
local status, telescope = pcall(require, "telescope")
local actions = require('telescope.actions')
if (not status) then return end

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-f>"] = actions.to_fuzzy_refine,
      },
      n = {
        ["<C-c>"] = actions.close,
      }
    },
    preview = {
      treesitter = false,
    }
  },
  pickers = {
    find_files = {
      hidden = true
    },
    buffers = {
      sort_lastused = true
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
      mappings = {
        i = {
          ["<CR>"] = require("telescope-undo.actions").restore,
        },
      }
    }
  }
}
telescope.load_extension "ag"
telescope.load_extension "fzf"
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

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.mypy.with({
      diagnostics_format = '[mypy] #{m}\n(#{c})',
      -- Have to specify the path to mypy (installed by global arm pip3) because auto installed with Mason
      -- failes to detect extra pliugin/types installed
      prefer_local = 'venv/bin',
      -- command = "/opt/homebrew/bin/mypy",
    }),
    null_ls.builtins.completion.spell,

    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.black.with { extra_args = { "--fast" } },
  },
  on_attach = function(client, bufnr)
    -- format on the file save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end
})

-- skip string normalization for Black by setting variable g:black_skip_string_normalization
vim.g.black_skip_string_normalization = 1

-- prettier
local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  }
}


if vim.fn.has('nvim') == 1 and vim.fn.executable('nvr') == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- Toggle diagnostics
require('toggle_lsp_diagnostics').init()

-- chatgpt
local status, chatgpt = pcall(require, "chatgpt")
if (not status) then return end

chatgpt.setup {
    api_key_cmd = nil,
    yank_register = "+",
    chat = {
      keymaps = {
        close = { "<C-c>" },
        yank_last = "<C-y>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
        cycle_modes = "<C-f>",
        select_session = "<Space>",
        rename_session = "r",
        delete_session = "d",
        draft_message = "<C-d>",
        toggle_settings = "<C-o>",
        toggle_message_role = "<C-r>",
        toggle_system_role_open = "<C-s>",
      },
    },
    edit_with_instructions = {
      diff = false,
      keymaps = {
        close = "<C-c>",
        accept = "<C-y>",
        toggle_diff = "<C-d>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
        use_output_as_input = "<C-h>",
      },
    },
    popup_input = {
      prompt = " 🚀 ",
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = {
          top_align = "center",
          top = " Prompt ",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
      submit = "<C-Enter>",
      submit_n = "<Enter>",
    },
    actions_paths = {
        '/Users/leikoilja/Development/dotfiles/nvim-chatgpt-actions/js.json'
    },
}

-- Whichkey mapping
local wk = require("which-key")
wk.add({
  -- AI Group
  { "<leader>c", group = "AI" },
  { "<leader>ca", "<cmd>ChatGPTRun add_cypress_component_tests<CR>", desc = "Add Tests" },
  { "<leader>cb", "Toggle Copilot" },
  { "<leader>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
  { "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
  { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
  { "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
  { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
  { "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
  { "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
  { "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
  { "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
  { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
  { "<leader>ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
  { "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
  { "<leader>cp", ":Copilot panel<CR>", desc = "Copilot panel", mode = "n", noremap = true, silent = true },
  -- { "<leader>ct", "<cmd>lua require('copilot').toggle()<CR>", desc = "Toggle Copilot", mode = "n", noremap = true, silent = true },

  -- Find Group
  { "<leader>f", group = "Find" },
  { "<leader>ff", "<cmd>lua require('fzf-lua').git_files()<cr>", desc = "Find git file", mode = "n", silent = true },
  { "<leader>fF", "<cmd>lua require('fzf-lua').files()<cr>", desc = "Find file in the project", mode = "n", silent = true },
  { "<leader>fp", "<cmd>lua require('fzf-lua').grep_project()<cr>", desc = "Silver search in the project", mode = "n", silent = true },
  { "<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<cr>", desc = "Find word in project", mode = "n", silent = true },
  { "<leader>fcf", "<cmd>lua require('fzf-lua').grep_last()<cr>", desc = "Continue last FZF search", mode = "n", silent = true },

  -- Buffer Group
  { "<leader>b", "<cmd>lua require('fzf-lua').buffers()<cr>", desc = "Find buffers", mode = "n", silent = true },

  -- Sorting
  { "<leader>S", ":sort <CR>", desc = "Sort selection", mode = "v", noremap = true },

  -- Git Group
  { "<leader>g", group = "Git" },
  { "<leader>gg", ":LazyGit<CR>", desc = "Open lazygit", mode = "n", silent = true },
  { "<leader>gb", "<cmd>GitBlameToggle<CR>", desc = "Git blame toggle", mode = "n", noremap = true },
  { "<leader>gi", "<cmd>GitBlameOpenCommitURL<CR>", desc = "Open commit URL in browser", mode = "n", noremap = true },
  { "<leader>go", ':lua require"github".octo_menu()<cr>', desc = "Octo menu", mode = "n", noremap = true },

  -- File Tree Group
  { "<leader>n", group = "File tree" },
  { "<leader>nf", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in NvimTree", mode = "n", noremap = true },
  { "<leader>nt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree", mode = "n", noremap = true },

  -- Terminal and Editor Group
  { "<leader>t", group = "Terminal and editor" },
  { "<leader>tt", ':lua require"utils".JBLRunCurrentTest("one")<cr>', desc = "Run current test (one)", mode = "n", noremap = true },
  { "<leader>tf", ':lua require"utils".JBLRunCurrentTest()<cr>', desc = "Run current test", mode = "n", noremap = true },
  { "<leader>tl", [[:<C-u>exec v:count .. 'Tclear'<cr>]], desc = "Clear terminal", mode = "n", noremap = true, silent = true },
  { "<leader>tc", "Toggle color scheme" },
  { "<leader>tr", [[:<C-u>exec printf("%sTexec !! \<lt>cr>", v:count)<cr>]], desc = "Rerun last command", mode = "n", noremap = true, silent = true },
  { "<leader>ts", group = "Send" },
  { "<leader>tss", '<Plug>(neoterm-repl-send)', desc = "Send selected text to REPL", mode = "v", noremap = true },

  -- Trouble Group
  { "<leader>x", group = "Trouble" },

  { "<leader>xt", '<Plug>(toggle-lsp-diag)', desc = "Toggle LSP diagnostics", mode = "n", noremap = true },
  { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics", mode = "n", noremap = true, silent = true },
  { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics", mode = "n", noremap = true, silent = true },

  -- Renamer Group
  { "<leader>r", '<cmd>lua require("renamer").rename()<cr>', desc = "Rename", mode = "n", noremap = true, silent = true },

  -- File/Window
  { "<leader>w", group = "File/Window" },
  { "<leader>ww", ":update<CR>", desc = "Save file", mode = "n", noremap = true, silent = true },
  { "<leader>we", ":e<CR>", desc = "Edit file", mode = "n", noremap = true, silent = true },
  { "<leader>wo", ":only<CR>", desc = "Close other windows", mode = "n", silent = true },

  -- Others
  { "<leader>e", "<cmd>SymbolsOutline<CR>", desc = "Show Symbols Outline", mode = "n", noremap = true },
  { "<leader><leader>", "<cmd>HopChar2<CR>", desc = "Hop Char2", mode = "n", noremap = true },
  { "<leader><leader>", "<Esc>", desc = "Escape to normal mode", mode = "i" },
  { "<leader><leader>", "<C-\\><C-n>", desc = "Escape terminal", mode = "t", silent = true },
  { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Telescope Undo", mode = "n" },
}, { mode = { "n", "v" } })


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
    auto_close = true,
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
local ok, autosession = pcall(require, "auto-session")
if not ok then return end
autosession.setup {
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

-- git blame
vim.g.gitblame_enabled = 0
vim.g.gitblame_date_format = '%x %H:%M'
vim.g.gitblame_message_when_not_committed = ' Oh please, commit this!'

local ok, colorizer = pcall(require, "colorizer")
if not ok then return end

-- Colorizer, is known to make live_grep freeze
-- https://github.com/lilydjwg/colorizer
colorizer.setup(
    { "css", "scss", "javascript", "lua", "vim", "toml", "svelte", "typescript" },
    {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue oe blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background, virtualtext
        mode = "background", -- Set the display mode.)
    }
)

-- Theme setup
require("gruvbox").setup({})

-- activate default color scheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

local color_schemes = {
    "gruvbox",
    "catppuccin-latte",
}

local current_scheme = 1

function toggle_color_scheme()
    current_scheme = current_scheme % #color_schemes + 1
    if current_scheme == 1 then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end
    vim.cmd("colorscheme " .. color_schemes[current_scheme])
end

vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>lua toggle_color_scheme()<CR>', { noremap = true, silent = true })


-- disable putting comments on new lines
vim.cmd("au FileType * set fo-=c fo-=r fo-=o")

-- Set python interpreter
vim.g.python3_host_prog = '~/Development/Envs/nvim/bin/python'

-- Set node interpreter
vim.g.node_host_prog = '/Users/leikoilja/.nvm/versions/node/v20.12.2/lib/node_modules/neovim/bin/cli.js'

-- renamer
local status, renamer = pcall(require, "renamer")
if (not status) then return end

renamer.setup {
  show_refs = true,
  empty = false,
}

-- Octo
-- https://github.com/tuanbass/doom-nvim/tree/tuanbass/lua/user/modules/features/github
--
-- require"octo".setup({
--   default_remote = {"origin", "upstream"}; -- order to try remotes
--   mappings = {
--     issue = {
--       close_issue = { lhs = "<leader>ic", desc = "close issue" },
--       reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
--       list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
--       reload = { lhs = "<C-r>", desc = "reload issue" },
--       open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
--       copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
--       add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
--       remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
--       create_label = { lhs = "<leader>lc", desc = "create label" },
--       add_label = { lhs = "<leader>la", desc = "add label" },
--       remove_label = { lhs = "<leader>ld", desc = "remove label" },
--       goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
--       add_comment = { lhs = "<leader>ca", desc = "add comment" },
--       delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
--       next_comment = { lhs = "]c", desc = "go to next comment" },
--       prev_comment = { lhs = "[c", desc = "go to previous comment" },
--       react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
--       react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
--       react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
--       react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
--       react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
--       react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
--       react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
--       react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
--     },
--     pull_request = {
--       checkout_pr = { lhs = "<leader>po", desc = "checkout PR" },
--       merge_pr = { lhs = "<leader>pm", desc = "merge commit PR" },
--       squash_and_merge_pr = { lhs = "<leader>psm", desc = "squash and merge PR" },
--       list_commits = { lhs = "<leader>pc", desc = "list PR commits" },
--       list_changed_files = { lhs = "<leader>pf", desc = "list PR changed files" },
--       show_pr_diff = { lhs = "<leader>pd", desc = "show PR diff" },
--       add_reviewer = { lhs = "<leader>va", desc = "add reviewer" },
--       remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer request" },
--       close_issue = { lhs = "<leader>ic", desc = "close PR" },
--       reopen_issue = { lhs = "<leader>io", desc = "reopen PR" },
--       list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
--       reload = { lhs = "<C-r>", desc = "reload PR" },
--       open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
--       copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
--       goto_file = { lhs = "gf", desc = "go to file" },
--       add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
--       remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
--       create_label = { lhs = "<leader>lc", desc = "create label" },
--       add_label = { lhs = "<leader>la", desc = "add label" },
--       remove_label = { lhs = "<leader>ld", desc = "remove label" },
--       goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
--       add_comment = { lhs = "<leader>ca", desc = "add comment" },
--       delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
--       next_comment = { lhs = "]c", desc = "go to next comment" },
--       prev_comment = { lhs = "[c", desc = "go to previous comment" },
--       react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
--       react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
--       react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
--       react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
--       react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
--       react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
--       react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
--       react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
--     },
--     review_thread = {
--       goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
--       add_comment = { lhs = "<leader>ca", desc = "add comment" },
--       add_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
--       delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
--       next_comment = { lhs = "]c", desc = "go to next comment" },
--       prev_comment = { lhs = "[c", desc = "go to previous comment" },
--       select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
--       select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--       react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
--       react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
--       react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
--       react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
--       react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
--       react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
--       react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
--       react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
--     },
--     submit_win = {
--       approve_review = { lhs = "<C-a>", desc = "approve review" },
--       comment_review = { lhs = "<C-m>", desc = "comment review" },
--       request_changes = { lhs = "<C-r>", desc = "request changes review" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--     },
--     review_diff = {
--       add_review_comment = { lhs = "<leader>ca", desc = "add a new review comment" },
--       add_review_suggestion = { lhs = "<leader>sa", desc = "add a new review suggestion" },
--       focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
--       toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
--       next_thread = { lhs = "]t", desc = "move to next thread" },
--       prev_thread = { lhs = "[t", desc = "move to previous thread" },
--       select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
--       select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--       toggle_viewed = { lhs = "<leader><leader>", desc = "toggle viewer viewed state" },
--       goto_file = { lhs = "gf", desc = "go to file" },
--     },
--     file_panel = {
--       next_entry = { lhs = "j", desc = "move to next changed file" },
--       prev_entry = { lhs = "k", desc = "move to previous changed file" },
--       select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
--       refresh_files = { lhs = "R", desc = "refresh changed files panel" },
--       focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
--       toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
--       select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
--       select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--       toggle_viewed = { lhs = "<leader><leader>", desc = "toggle viewer viewed state" },
--     }
--   }
-- })

