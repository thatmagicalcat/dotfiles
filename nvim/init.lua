require("magical")

-- neovide settings
vim.g.neovide_opacity = 0.85
vim.g.neovide_normal_opacity = 0.85
vim.g.neovide_cursor_animation_length = 0.2
vim.g.neovide_cursor_vfx_mode = {"railgun"}
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.o.guifont = "JetBrainsMono Nerd Font:h16"

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.getbufvar('%', '&modified') == 0 then
      vim.cmd('checktime')
    end
  end,
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.clipboard = "unnamedplus"
