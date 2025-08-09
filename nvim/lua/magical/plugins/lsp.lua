-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--         -- "hrsh7th/nvim-cmp",
--         -- "hrsh7th/cmp-nvim-lsp",
--         -- "hrsh7th/cmp-buffer",
--         -- "hrsh7th/cmp-path",
--         -- "hrsh7th/cmp-cmdline",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--     },
-- }

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {}
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end
}
