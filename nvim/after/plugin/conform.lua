require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt", lsp_format = "fallback" },
		haskell = { "ormolu" }
	},
})
