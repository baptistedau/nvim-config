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
