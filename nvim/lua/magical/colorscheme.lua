-- local colorscheme = "gruvbox"
-- local colorscheme = "monokai_pro"

-- local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not is_ok then
--     vim.notify("colorscheme " .. colorscheme .. " not found!")
--     return
-- end

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- local path = vim.fn.stdpath("config") .. "/lua/magical/zenwritten.vim"
-- vim.api.nvim_exec2("source " .. path, { output = false })
vim.api.nvim_set_hl(0, "Normal", { bg = "#080808" })
