vim.g.opencode_opts = {
    port = 4096,
    provider = {
        enabled = "snacks",
        cmd = "opencode --agent neovim",
    },
}

vim.o.autoread = true

local opencode = require("opencode")

vim.keymap.set({ "n", "x" }, "<leader>.d", function() opencode.ask(" @this: ", { submit = true }) end,
    { desc = "Ask opencode and submit" })
vim.keymap.set({ "n", "x" }, "<leader>.a", function() opencode.ask(" @this: ", {}) end,
    { desc = "append Ask opencode" })
vim.keymap.set("n", "<leader>.n", function() opencode.command('session.new') end, { desc = "Create new session" })
vim.keymap.set({ "n", "x" }, "<leader>.s", function() opencode.select() end, { desc = "Execute opencode action…" })
