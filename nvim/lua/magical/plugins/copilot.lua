return {
    "github/copilot.vim",
    lazy = true,
    init = function()
        vim.api.nvim_create_user_command("CopilotEnable", function()
            require("lazy").load({ plugins = { "copilot.vim" } })
            print("Copilot enabled")
        end, {})
    end,
}
