return {
	'saghen/blink.cmp',
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
			}
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
