return {
    "mfussenegger/nvim-dap",
    config = function ()
        local dap = require('dap')

        dap.adapters.lldb = {
            type = 'executable',
            command = '/run/current-system/sw/bin/lldb-dap',
            name = 'lldb'
        }

        dap.defaults.fallback.external_terminal = {
            command = 'kitty',
            args = {'-e'},
        }

        dap.configurations.rust = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                terminal = 'external',
                args = {},
                initCommands = function()
                    local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
                    assert(
                    vim.v.shell_error == 0,
                        'failed to get rust sysroot using `rustc --print sysroot`: '
                        .. rustc_sysroot
                    )
                    local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
                    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                    -- The following is a table/list of lldb commands, which have a syntax
                    -- similar to shell commands.
                    --
                    -- To see which command options are supported, you can run these commands
                    -- in a shell:
                    --
                    --   * lldb --batch -o 'help command script import'
                    --   * lldb --batch -o 'help command source'
                    --
                    -- Commands prefixed with `?` are quiet on success (nothing is written to
                    -- debugger console if the command succeeds).
                    --
                    -- Prefixing a command with `!` enables error checking (if a command
                    -- prefixed with `!` fails, subsequent commands will not be run).
                    --
                    -- NOTE: it is possible to put these commands inside the ~/.lldbinit
                    -- config file instead, which would enable rust types globally for ALL
                    -- lldb sessions (i.e. including those run outside of nvim). However,
                    -- that may lead to conflicts when debugging other languages, as the type
                    -- formatters are merely regex-matched against type names. Also note that
                    -- .lldbinit doesn't support the `!` and `?` prefix shorthands.
                    return {
                        ([[!command script import '%s']]):format(script_file),
                        ([[command source '%s']]):format(commands_file),
                    }
                end,
                -- ...,
            },
        }

        vim.keymap.set('n', '<F5>', dap.continue, { desc = "Debug: Start/Continue" })
        vim.keymap.set('n', '<F9>', dap.step_back, { desc = "Debug: Step Back" })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Debug: Step Out" })

        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set('n', '<leader>dB', function()
          dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end, { desc = "Debug: Set Conditional Breakpoint" })

        vim.keymap.set('n', '<leader>di', function() 
          require('dap.ui.widgets').hover() 
        end, { desc = "Debug: Hover Variables" })

        vim.keymap.set('n', '<leader>ds', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end, { desc = "Debug: View Scopes" })

        vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = "Debug: Open REPL" })
        vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = "Debug: Run Last Session" })
        vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = "Debug: Terminate Session" })
    end
}
