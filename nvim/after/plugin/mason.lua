require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "hls", "clangd", "pyright", "ts_ls", "wgsl_analyzer", "gopls" },
    automatic_installation = true,
})
