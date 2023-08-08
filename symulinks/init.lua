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
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fF', builtin.find_files, {})
vim.keymap.set('n', '<leader>fct', '<cmd>:Telescope resume<cr>', {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})

-- fzf
vim.keymap.set('n', '<leader>fp', '<cmd>:FzfLua grep_project<cr>', {})
vim.keymap.set('n', '<leader>fcf', '<cmd>:FzfLua grep_last<cr>', {})
vim.keymap.set('n', '<leader>fw', '<cmd>:FzfLua grep_cword<cr>', {})

-- Switch vim tabs
-- vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
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
vim.api.nvim_set_keymap('n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>', { noremap = true })

-- Symbols outline (tagline)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>SymbolsOutline<CR>', { noremap = true })

-- ChatGPT
vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>ChatGPT<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>ChatGPTActAs<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>ci', '<cmd>ChatGPTEditWithInstructions<CR>', { noremap = true })

-- lazygit inside floatearm
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>FloatermNew --width=1.0 --height=1.0 lazygit --use-config-file="$HOME/.lazygit_config.yml"<CR>', { noremap = true })

-- search under cursor
vim.api.nvim_set_keymap('n', '<CR>', [[:let @/ = '\<<C-r><C-w>\>' | :set hlsearch<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':set invhlsearch<CR>', { noremap = true })

-- git blame
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>GitBlameToggle<CR>', { noremap = true })

-- copilot
-- vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>(copilot-next)", { noremap = false, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-h>", "<Plug>(copilot-previous)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cp", ":Copilot panel<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ct", ":lua require('copilot').toggle()<CR>", { noremap = true, silent = true })

-- Close window if it's the last one, otherwise close buffer
-- vim.api.nvim_set_keymap("n", "Q", ":if winnr('$') > 1 | q | else | bd | endif<CR>", { noremap = true, silent = true })

-- renamer
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })

-- octo commands picker
vim.api.nvim_set_keymap('n', '<leader>go', ':lua require"github".octo_menu()<cr>' , { noremap = true })

-- settings

-- editorconfig (should be neovim default, but was not yet released on the stable version)
-- vim.g.editorconfig = true

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
    ensure_installed = { "eslint", "djlint", "mypy" }
})

require("mason").setup()

-- Pin node version that neovim will use
-- vim.g.node_host_prog = '~/.nvm/versions/node/v18.16.0/bin/node'

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')

lspconfig.eslint.setup{}
lspconfig.pylsp.setup{}
lspconfig.pyright.setup{}
lspconfig.tailwindcss.setup {}

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
  -- suggestion = {
  --   enabled = true,
  --   auto_trigger = true,
  --   debounce = 75,
  --   keymap = {
  --     accept = "<TAB>",
  --     accept_word = false,
  --     accept_line = false,
  --     next = "<C-l>",
  --     prev = "<C-h>",
  --     dismiss = "<C-]>",
  --   },
  -- },
  suggestion = { enabled = false },
  filetypes = {
    -- help = false,
    -- yaml = false,
    -- markdown = false,
    -- gitcommit = false,
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
lspconfig.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = function(client)
      client.server_capabilities.document_formatting = false  -- disable tsserver formatting to avoid conflicts with null-ls
  end,
}

-- Hide inline diagnostic
-- vim.diagnostic.disable()

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
    -- vim.keymap.set('n', '<leader>xD', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>xr',vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>xa',vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>F', function()
      vim.lsp.buf.format { async = true }
    end, opts)
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
        ["<C-h>"] = actions.select_horizontal,
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
          -- ["<C-y>"] = require("telescope-undo.actions").yank_additions,
          -- ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
          ["<CR>"] = require("telescope-undo.actions").restore,
        },
      }
    }
  }
}
telescope.load_extension "ag"
telescope.load_extension "fzf"
telescope.load_extension "undo"

-- fzf (real one)
local status, fzf_lua = pcall(require, "fzf-lua")
fzf_lua.setup(
  {
    'telescope', -- set profile close to telescope in looks and feels
    lsp = {
        -- make lsp requests synchronous so they work with null-ls
        async_or_timeout = 3000,
    },
    grep = {
      -- ignore directiries during fuzzy grep search
      cmd = "rg --color=always --smart-case -g '!{.git,node_modules,tinymce}/'"
    }
  }
)

-- require'fzf-lua'.grep({ })

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
    -- null_ls.builtins.diagnostics.eslint_d.with({
    --   diagnostics_format = '[eslint] #{m}\n(#{c})'
    -- }),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.mypy.with({
      diagnostics_format = '[mypy] #{m}\n(#{c})',
      -- Have to specify the path to mypy (installed by global arm pip3) because auto installed with Mason
      -- failes to detect extra pliugin/types installed
      prefer_local = 'venv/bin',
      -- command = "/opt/homebrew/bin/mypy",
    }),
    null_ls.builtins.completion.spell,

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

-- Toggle diagnostics
require('toggle_lsp_diagnostics').init()

-- chatgpt
local status, chatgpt = pcall(require, "chatgpt")
if (not status) then return end

chatgpt.setup {
    api_key_cmd = nil,
    yank_register = "+",
    chat = {
      -- welcome_message = WELCOME_MESSAGE,
      -- loading_text = "Loading, please wait ...",
      -- question_sign = "",
      -- answer_sign = "ﮧ",
      -- max_line_length = 120,
      -- sessions_window = {
      --   border = {
      --     style = "rounded",
      --     text = {
      --       top = " Sessions ",
      --     },
      --   },
      --   win_options = {
      --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      --   },
      -- },
      keymaps = {
        close = { "<C-c>" },
        yank_last = "<C-y>",
        yank_last_code = "<C-k>",
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
    -- popup_layout = {
    --   default = "center",
    --   center = {
    --     width = "80%",
    --     height = "80%",
    --   },
    --   right = {
    --     width = "30%",
    --     width_settings_open = "50%",
    --   },
    -- },
    -- popup_window = {
    --   border = {
    --     highlight = "FloatBorder",
    --     style = "rounded",
    --     text = {
    --       top = " ChatGPT ",
    --     },
    --   },
    --   win_options = {
    --     wrap = true,
    --     linebreak = true,
    --     foldcolumn = "1",
    --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    --   },
    --   buf_options = {
    --     filetype = "markdown",
    --   },
    -- },
    -- system_window = {
    --   border = {
    --     highlight = "FloatBorder",
    --     style = "rounded",
    --     text = {
    --       top = " SYSTEM ",
    --     },
    --   },
    --   win_options = {
    --     wrap = true,
    --     linebreak = true,
    --     foldcolumn = "2",
    --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    --   },
    -- },
    -- settings_window = {
    --   border = {
    --     style = "rounded",
    --     text = {
    --       top = " Settings ",
    --     },
    --   },
    --   win_options = {
    --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    --   },
    -- },
    -- openai_params = {
    --   model = "gpt-3.5-turbo",
    --   frequency_penalty = 0,
    --   presence_penalty = 0,
    --   max_tokens = 300,
    --   temperature = 0,
    --   top_p = 1,
    --   n = 1,
    -- },
    -- openai_edit_params = {
    --   model = "code-davinci-edit-001",
    --   temperature = 0,
    --   top_p = 1,
    --   n = 1,
    -- },
    -- actions_paths = {},
    -- show_quickfixes_cmd = "Trouble quickfix",
    -- predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
}

-- Whichkey mapping
local wk = require("which-key")

wk.register({
  c = {
    name = "AI",
    t = { "Toggle Copilot" },
    i = {
        function()
            chatgpt.edit_with_instructions()
        end,
        "Edit with instructions",
    },
  },
  f = {
    name = "find",
    f = { "Find git file" },
    F = { "Find file in the project" },
    p = { "Silver search in the project" },
    w = { "Find word in project" },
    c = {
      name = "Resume",
      t = { "Continue last Telescope search" },
      f = { "Continue last FZF search" },
    }
  },
  g = {
    name = "git",
  },
  r = {
    name = "Renamer",
  },
  x = {
    name = "trouble",
    t = { "Toggle diagnostics" },
  },
  n = {
    name = "File tree",
    f = { "Focus on the current file" },
    t = { "Toggle the tree" },
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
}, { prefix = "<leader>", mode = "v" })


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


-- neogit
-- local neogit = require('neogit')
--
-- neogit.setup {
--     integrations = {
--         diffview = true
--     }
-- }

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

-- git blame
vim.g.gitblame_enabled = 0

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
-- vim.o.background = "dark" -- or "light" for light mode
require("gruvbox").setup({})
vim.cmd([[colorscheme gruvbox]])
-- vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme kanagawa-lotus")
-- vim.cmd("colorscheme kanagawa-dragon")

-- disable putting comments on new lines
vim.cmd("au FileType * set fo-=c fo-=r fo-=o")

-- Set python interpreter
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

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

