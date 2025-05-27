vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nowrap")
vim.cmd("set laststatus=3")
-- keymaps for parsing input and output sweat shop aiyya 😩
vim.keymap.set("n", "<leader>i", function()
	vim.cmd([[ g!/input/d ]])
	vim.cmd([[ %s/...."input": "\(.*\)",/\1/ ]])
	vim.cmd([[ %s/\\n/\r/g ]])
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>o", function()
	vim.cmd([[ g!/output/d ]])
	vim.cmd([[ %s/...."output": "\(.*\)"/\1/ ]])
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>jo", function()
	vim.cmd([[ %s/\(.*\) /\1/ ]])
end, { noremap = true, silent = true })
vim.opt.clipboard:append("unnamedplus")

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "sak.plugins" },
	{ import = "sak.plugins.lsp" },
})

require("sak.utils.cpp")
