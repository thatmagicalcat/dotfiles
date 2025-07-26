local lspconfig = require("lspconfig")

-- Keybinds
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Info" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "References" })

vim.keymap.set("n", "<C-f>", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

vim.diagnostic.config({
    virtual_text = {
        prefix = "»",
        spacing = 2,
    },
    signs = true,
    undejline = true,
    update_in_insert = false,
    severity_sort = true,
})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the LSP you're using LuaJIT (which Neovim uses)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Recognize `vim` as a global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy";
            }
        },
    },
})

lspconfig.clangd.setup({
  cmd = { "clangd", "--fallback-style=LLVM" },
})
