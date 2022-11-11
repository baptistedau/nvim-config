-- Nvim lsp installer & config
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local signature = require("lsp_signature")

signature.setup({
    bind = true,
    hint_enable = false,
})

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
