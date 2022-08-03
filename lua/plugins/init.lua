return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UI
    require("plugins/ui-config")
    use {
        'navarasu/onedark.nvim'
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'p00f/nvim-ts-rainbow',
        },
        run = ":TSUpdate"
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        }
    }


    -- LSP Stuff
    require("plugins/lsp-config")
    use {
        'williamboman/nvim-lsp-installer',
        requires = { 'neovim/nvim-lspconfig' }
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'neovim/nvim-lspconfig'
        }
    }

    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- Random stuff
    use 'ntpeters/vim-better-whitespace'

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

end)
