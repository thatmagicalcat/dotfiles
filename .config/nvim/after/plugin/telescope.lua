local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>F', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>s', function ()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Telescope find files' })
