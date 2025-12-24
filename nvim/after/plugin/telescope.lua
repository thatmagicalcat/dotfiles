local builtin = require('telescope.builtin')
local telescope = require("telescope")
local actions = require("telescope.actions")

local binding = {
    ["<c-d>"] = actions.delete_buffer,
    ["<c-j>"] = actions.move_selection_next,
    ["<c-k>"] = actions.move_selection_previous,
}

local keymap = {
    mappings = {
        i = binding,
        n = binding,
    }
}

telescope.setup({
    pickers = {
        find_files = keymap,
        buffers = keymap,
    }
})

vim.keymap.set('n', '<c-h>', builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>F', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>s', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Telescope find files' })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function () 
        vim.keymap.set("n", "<leader>f", function ()
            builtin.find_files({
                cwd = vim.b.netrw_curdir,
            })
        end, { buffer = true, desc = "Telescope find files in netrw" })
    end
})
