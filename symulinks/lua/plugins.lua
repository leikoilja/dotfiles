local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]


packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'ellisonleao/gruvbox.nvim' -- theme
    use "rebelot/kanagawa.nvim"  -- theme
    use {
        "williamboman/mason.nvim",  -- mason LSP server management
        "neovim/nvim-lspconfig",  -- neovim lspconfig
        "williamboman/mason-lspconfig.nvim",  -- bridge between mason and lspconfig
        'jose-elias-alvarez/null-ls.nvim',  -- use neovim as a language server to inject LSP
        "jay-babu/mason-null-ls.nvim",  -- bridge between mason and null-ls
        'MunifTanjim/prettier.nvim',  -- prettier plugin for LSP
    }
    use 'onsails/lspkind-nvim' -- VSCode-like pictograms
    use {  -- list to show LSP diagnostics, references
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' -- toggle diagnostics
    use {
        'nvim-lualine/lualine.nvim', -- statusbar
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'arkav/lualine-lsp-progress'  -- statusbar LSP status
    use {  -- which key
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 600
      end
    }
    use "terrortylor/nvim-comment" -- commenter
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "hrsh7th/nvim-cmp" -- A completion engine plugin for neovim
    use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim's built-in LSP
    use "hrsh7th/cmp-buffer" -- nvim-cmp source for buffer words
    use { -- treesitter code parser
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    use "windwp/nvim-ts-autotag" -- auto close and auto rename tags
    use "windwp/nvim-autopairs" -- auto pair brackets
    use 'nvim-tree/nvim-web-devicons' -- dev icons
    use {  -- telescope search engine
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }  -- telescope sorter
    use { 'junegunn/fzf', run = './install --bin' } -- fzf
    use { 'ibhagwan/fzf-lua',  -- fzf
      -- optional for icon support
      requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use({ -- silver searcher
      "kelly-lin/telescope-ag",
      requires = { "nvim-telescope/telescope.nvim" },
    })
    use {  -- telescope undo tree
      "debugloop/telescope-undo.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use {  -- bufferline
      'akinsho/bufferline.nvim', tag = "v3.*",
      requires = 'nvim-tree/nvim-web-devicons'
    }
    use {  -- git changes on the side
      'lewis6991/gitsigns.nvim',
    }
    use {  -- terminal wrapper
      'kassio/neoterm',
    }
    use {  -- hop is easymotion alternative
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
    }
    use 'wakatime/vim-wakatime'  -- dev metrics
    use 'mg979/vim-visual-multi' -- multi cursor
    use {  -- file tree
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require("nvim-tree").setup {}
      end
    }
    use 'simrat39/symbols-outline.nvim' -- tagbar alternative
    use {  -- dashboard
      'goolord/alpha-nvim',
      requires = { 'nvim-tree/nvim-web-devicons' },
    }
    use {  -- session manager
      'rmagatti/auto-session',
    }
    use {  -- git solution
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'  -- diff view
      }
    }
    use 'kchmck/vim-coffee-script'  -- coffeescript support
    use 'editorconfig/editorconfig-vim' -- editorconfig support
    use({  -- surround
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    })
    use 'f-person/git-blame.nvim'  -- git blame
    use 'norcalli/nvim-colorizer.lua'  -- color highlight on the color code
end)
