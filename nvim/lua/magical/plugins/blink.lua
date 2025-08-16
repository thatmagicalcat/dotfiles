return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },

	version = '1.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = 'enter' },
		appearance = {
			nerd_font_variant = 'mono'
		},

		completion = {
			trigger = {
				show_on_trigger_character = true,
				show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
				update_delay_ms = 300,
			},
			ghost_text = {
				enabled = true,
				show_with_menu = true,
			},
			menu = {
				auto_show = false,
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,

							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						}
					}
				}
			}
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
