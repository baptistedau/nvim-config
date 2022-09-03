-- OneDark
require("onedark").setup({
    style = "warmer"
})
vim.cmd("colorscheme onedark")

-- BufferLine
require("bufferline").setup({})

-- LuaLine
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

-- Treesitter
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

require("nvim-tree").setup({})
