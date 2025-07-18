require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "hls", "clangd", "pyright" },
    automatic_installation = true,
})
