local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local compiled_path = fn.stdpath('config')..'/plugin'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  fn.system({'rm', '-r', compiled_path})
  vim.cmd [[packadd packer.nvim]]
end

local packer = require("packer")

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
})

function get_require(name)
    return string.format('plugins.setup.%s', name)
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UI
    use {
        'navarasu/onedark.nvim',
        config = function() require(get_require("onedark")) end
    }

    use {
        'APZelos/blamer.nvim',
        config = function() require(get_require("blamer")) end
    }

    use {
        'kyazdani42/nvim-web-devicons'
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        config = function() require(get_require("bufferline")) end
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function() require(get_require("lualine")) end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() require(get_require("treesitter")) end,

        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use {
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter'
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim'
        },
        config = function() require(get_require("nvim_telescope")) end,
    }

    use {
        'kyazdani42/nvim-tree.lua',
        after = 'nvim-web-devicons',
        config = function() require(get_require("nvim_tree")) end,
    }


    use { "williamboman/mason.nvim" }

    use {
        "williamboman/mason-lspconfig.nvim",
        after = 'mason.nvim'
    }

    use {
        "neovim/nvim-lspconfig",
        after = "mason-lspconfig.nvim",
        config = function() require(get_require("lsp")) end,
    }

    use {
        'hrsh7th/nvim-cmp',
        after = "nvim-lspconfig"
    }


    use {
        'L3MON4D3/LuaSnip',
        after = "nvim-cmp"
    }

    use {
        'hrsh7th/cmp-nvim-lsp',
        after = "LuaSnip",
        config = function() require(get_require("lsp_cmp")) end,
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = function() require(get_require("lsp_signature")) end,
    }

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
        config = function() require(get_require('gitsigns')) end
    }

    use "tpope/vim-fugitive"

    use {
        "windwp/nvim-autopairs",
        config = function() require(get_require('autopairs')) end
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
end)
