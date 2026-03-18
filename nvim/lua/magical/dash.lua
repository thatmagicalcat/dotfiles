local function open_dashboard()
  if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  
  local stats = require("lazy").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  
  local win_opts = {
    number = false,         -- No line numbers
    relativenumber = false, -- No relative numbers
    signcolumn = "no",      -- No sign column
    statuscolumn = "",      -- No status column (for Neovim 0.9+)
    foldcolumn = "0",       -- No fold column
    cursorline = false,     -- No horizontal line under cursor
  }
  
  -- 3. Content
  local header = {
    "Loaded " .. stats.count .. " plugins in " .. ms .. "ms",
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, header)
  
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("filetype", "dashboard", { buf = buf })
  vim.api.nvim_set_current_buf(buf)

  for opt, val in pairs(win_opts) do
    vim.api.nvim_set_option_value(opt, val, { scope = "local" })
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Small delay to ensure lazy.nvim finished loading stats
    vim.defer_fn(open_dashboard, 50)
  end,
})
