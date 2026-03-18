return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",
    lazy = true,
    keys = {
        { "<leader>s", desc = "Find Symbols (Document)" },
        { "<leader>F", desc = "Find Symbols (Workspace)" },
        { "<c-h>", desc = "Telescope buffers" },
        { "<leader>f", desc = "Telescope find files" },
        { "<leader>S", desc = "Telescope find files (Grep)" },
    },
    config = function()
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

        vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, { desc = 'Find Symbols (Document)' })
        vim.keymap.set('n', '<leader>F', builtin.lsp_dynamic_workspace_symbols, { desc = 'Find Symbols (Workspace)' })
        vim.keymap.set('n', '<c-h>', builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
        
        vim.keymap.set('n', '<leader>S', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = 'Telescope grep string' })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "netrw",
            callback = function()
                vim.keymap.set("n", "<leader>f", function()
                    builtin.find_files({
                        cwd = vim.b.netrw_curdir,
                    })
                end, { buffer = true, desc = "Telescope find files in netrw" })
            end
        })
    end
}
