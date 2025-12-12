local colorscheme = "gruvbox"
-- local colorscheme = "monokai_pro"

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
