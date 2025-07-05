local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "lua_ls", "hls", "rust_analyzer" }

for _, server in ipairs(servers) do
    local opts = {
        on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true)
            end
        end,
        capabilities = capabilities,
    }

    lspconfig[server].setup(opts)
end

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
