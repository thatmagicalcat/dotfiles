if vim.g.neovide then
    vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

vim.keymap.set("n", "<leader>p", "\"_dP")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
vim.keymap.set("n", "<C-x>", ":tabclose<CR>")
vim.keymap.set("n", "H", ":tabprevious<CR>")
vim.keymap.set("n", "L", ":tabnext<CR>")

-- For moving around wrapped lines
-- vim.keymap.set("n", "j", "gj")
-- vim.keymap.set("n", "k", "gk")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-Up>",    ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>",  ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- conform powered formatting
vim.keymap.set("n", "<C-f>", function()
    require('conform').format({ async = true, lsp_fallback = true })
end, { desc = "Format file (conform)" })
