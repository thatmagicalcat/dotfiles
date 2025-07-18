vim.g.mapleader = " "
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)

local opts = { noremap = true, silent = true }

-- For moving around wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-Up>",    ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>",  ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
