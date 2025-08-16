require("magical")

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
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'haskell',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.tabstop = 2
  end,
})

vim.g.dbs = {
	{ name = 'dev', url = 'postgres://postgres:mysecretpassword@localhost:5432/test' },
}
