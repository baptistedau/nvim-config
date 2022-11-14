-- Nvim lsp installer & config

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


local signature = require("lsp_signature")
signature.setup({
    bind = true,
    hint_enable = false,
})

-- Nvim cmp
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
