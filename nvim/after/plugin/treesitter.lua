require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "cpp", "lua", "rust", "haskell" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
