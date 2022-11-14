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
        'navarasu/onedark.nvim',
        config = function()
            require("onedark").setup({
                style = "warmer"
            })
            vim.cmd("colorscheme onedark")
        end
    }

    use {
        'kyazdani42/nvim-web-devicons'
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        config = function()
            require("bufferline").setup({})
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'onedark',
                    section_separators = '',
                    component_separators = '',
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = {
                    "c", "cpp", "vim", "lua", "make", "markdown",
                    "javascript", "html", "css", "cmake", "ocaml"
                },
                sync_install = false,

                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false
                },

                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil
                }
            })
        end,

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
        'kyazdani42/nvim-tree.lua',
        after = 'nvim-web-devicons',
        config = function() require("nvim-tree").setup({}) end
    }


    use { "williamboman/mason.nvim" }

    use {
        "williamboman/mason-lspconfig.nvim",
        after = 'mason.nvim'
    }

    use {
        "neovim/nvim-lspconfig",
        after = "mason-lspconfig.nvim",
        config = function()
            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local mason_lspcfg = require("mason-lspconfig")

            mason.setup {
                ui = {
                    icons = {
                        package_installed = "✓"
                    }
                }
            }
            mason_lspcfg.setup {
                ensure_installed = {},
                automatic_installation = true,
            }

            mason_lspcfg.setup_handlers {
                function (server_name) -- default handler (optional)
                    lspconfig[server_name].setup {}
                end,
            }
        end
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
        config = function()
            local luasnip = require 'luasnip'

            -- nvim-cmp setup
            local cmp = require 'cmp'
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            }
        end
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require("lsp_signature").setup({
                bind = true,
                hint_enable = false,
            })
        end
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
end)
