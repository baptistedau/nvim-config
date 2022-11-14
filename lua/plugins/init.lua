local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UI
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
    }

    use {
        'p00f/nvim-ts-rainbow',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        }
    }


    use { "williamboman/mason.nvim" }

    use { "williamboman/mason-lspconfig.nvim" }

    use { "neovim/nvim-lspconfig" }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'neovim/nvim-lspconfig'
        }
    }

    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    use 'ray-x/lsp_signature.nvim'

    use {
        'rhysd/vim-clang-format',
        requires = {
            'kana/vim-operator-user'
        }
    }

    -- Random stuff
    use 'ntpeters/vim-better-whitespace'

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    use "tpope/vim-fugitive"

    use { 
	"windwp/nvim-autopairs",
    	config = function() require ("nvim-autopairs").setup {} end
	}

    --[[
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
    ]]--

    if packer_bootstrap then
        require('packer').sync()
    end

    require("plugins/ui-config")
    require("plugins/lsp-config")
end)
