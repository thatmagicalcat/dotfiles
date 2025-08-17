local lspconfig = require("lspconfig")

-- Keybinds
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Info" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename" })

local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function(client, bufnr)
	vim.lsp.inlay_hint.enable(true)
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "»",
		spacing = 4,
		source = "if_many",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "if_many",
		border = "rounded",
	},
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- tell the LSP you're using LuaJIT (which Neovim uses)
				version = "LuaJIT",
			},
			diagnostics = {
				-- recognize `vim` as a global
				globals = { "vim" },
			},
			workspace = {
				-- make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			inlayHints = {
				bindingModeHints = {
					enable = true,
				},
				chainingHints = {
					enable = true,
				},
				closingBraceHints = {
					enable = true,
					minLines = 4,
				},
				closureCaptureHints = {
					enable = true,
				},
				closureReturnTypeHints = {
					enable = "always",
				},
				discriminantHints = {
					enable = "always",
				},
				implicitDrops = {
					enable = true,
				},
				implicitSizedBoundHints = {
					enable = true,
				},
				lifetimeElisionHints = {
					enable = true,
				}
			},
		},
	},
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	cmd = { "clangd", "--fallback-style=LLVM" },
})

lspconfig.hls.setup({
	capabilities = capabilities,
	settings = {
		haskell = {
			formattingProvider = 'ormolu',
		},
	},
})
