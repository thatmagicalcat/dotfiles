require('fff').setup({
	base_path = vim.fn.getcwd(), -- Base directory for file indexing
	max_results = 100, -- Maximum search results to display
	max_threads = 4, -- Maximum threads for fuzzy search
	prompt = ' ', -- Input prompt symbol
	title = 'FFF Files', -- Window title
	ui_enabled = false, -- Enable UI (default: true)

	-- Window dimensions
	width = 0.8, -- Window width as fraction of screen
	height = 0.8, -- Window height as fraction of screen

	-- Preview configuration
	preview = {
		enabled = true,                                               -- Enable preview pane
		width = 0.5,                                                  -- Preview width as fraction of window
		max_lines = 5000,                                             -- Maximum lines to load
		max_size = 10 * 1024 * 1024,                                  -- Maximum file size (10MB)
		imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit', -- ImageMagick info format
		line_numbers = true,                                          -- Show line numbers in preview
		wrap_lines = false,                                           -- Wrap long lines
		show_file_info = true,                                        -- Show file info header
		binary_file_threshold = 1024,                                 -- Bytes to check for binary detection
		filetypes = {                                                 -- Per-filetype settings
			svg = { wrap_lines = true },
			markdown = { wrap_lines = true },
			text = { wrap_lines = true },
			log = { tail_lines = 100 },
		},
	},

	-- Layout configuration (alternative to width/height)
	layout = {
		prompt_position = 'top', -- Position of prompt ('top' or 'bottom')
		preview_position = 'right', -- Position of preview ('right' or 'left')
		preview_width = 0.4,    -- Width of preview pane
		height = 0.8,           -- Window height
		width = 0.8,            -- Window width
	},

	-- Keymaps
	keymaps = {
		close = '<Esc>',
		select = '<CR>',
		select_split = '<C-s>',
		select_vsplit = '<C-v>',
		select_tab = '<C-t>',
		move_up = { '<Up>', '<C-k>' }, -- Multiple bindings supported
		move_down = { '<Down>', '<C-j>' },
		preview_scroll_up = '<C-u>',
		preview_scroll_down = '<C-d>',
		toggle_debug = '<F2>', -- Toggle debug scores display
	},

	-- Highlight groups
	hl = {
		border = 'FloatBorder',
		normal = 'Normal',
		cursor = 'CursorLine',
		matched = 'IncSearch',
		title = 'Title',
		prompt = 'Question',
		active_file = 'Visual',
		frecency = 'Number',
		debug = 'Comment',
	},

	-- Frecency tracking (track file access patterns)
	frecency = {
		enabled = true,                               -- Enable frecency tracking
		db_path = vim.fn.stdpath('cache') .. '/fff_nvim', -- Database location
	},

	-- Logging configuration
	logging = {
		enabled = true,                             -- Enable logging
		log_file = vim.fn.stdpath('log') .. '/fff.log', -- Log file location
		log_level = 'info',                         -- Log level (debug, info, warn, error)
	},

	-- UI appearance
	ui = {
		wrap_paths = true, -- Wrap long file paths in list
		wrap_indent = 2, -- Indentation for wrapped paths
		max_path_width = 80, -- Maximum path width before wrapping
	},

	-- Image preview (requires terminal with image support)
	image_preview = {
		enabled = false, -- Enable image previews
		max_width = 80, -- Maximum image width in columns
		max_height = 24, -- Maximum image height in lines
	},

	-- Icons
	icons = {
		enabled = true, -- Enable file icons
	},

	-- Debug options
	debug = {
		enabled = false, -- Enable debug mode
		show_scores = false, -- Show scoring information (toggle with F2)
	},
})
