return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

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
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require("bufferline").setup({}) end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
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
        requires = {
            'p00f/nvim-ts-rainbow',
        },
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
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
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        config = function() require("nvim-tree").setup({}) end
    }


    -- LSP Stuff
    use {
        'williamboman/nvim-lsp-installer',
        requires = { 'neovim/nvim-lspconfig' },
        config = function()
            local lsp_installer = require("nvim-lsp-installer")
            local lspconfig = require("lspconfig")
            lsp_installer.setup({ automatic_installation = true })

            lspconfig.util.default_config = vim.tbl_extend(
            "force",
            lspconfig.util.default_config,
            { on_attach = function(_, bufnr)
                vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    virtual_text = true,
                    signs = false,

                    -- delay update diagnostics
                    update_in_insert = false,
                }
                )
            end
        }
        )

        for _, server in ipairs(lsp_installer.get_installed_servers()) do
            lspconfig[server.name].setup {}
        end
    end
}

use {
    'hrsh7th/nvim-cmp',
    requires = {
        'saadparwaiz1/cmp_luasnip',
        'neovim/nvim-lspconfig'
    },
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
use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
use 'L3MON4D3/LuaSnip' -- Snippets plugin

-- Random stuff
use 'ntpeters/vim-better-whitespace'

use {
    'tanvirtin/vgit.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('vgit').setup() end
}

end)
