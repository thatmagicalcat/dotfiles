return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    lazy = true,
    keys = {
        {
            "<C-f>",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        }
    },

    opts = {
        formatters_by_ft = {
            rust = { "rustfmt", lsp_format = "fallback" },
            haskell = { "ormolu" },
            nim = { "nph" }
        }
    }
}
