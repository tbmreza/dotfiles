-- :h options
vim.opt.shiftwidth=2 -- >> and << read this
vim.opt.tabstop=2
vim.opt.expandtab=true -- expand means 'do not use'

local buffer = 0 -- current buffer
local opts = { noremap = true, silent = true }

vim.api.nvim_buf_set_keymap(
	buffer,
	"v", -- mode
	"<leader>dd", -- shorthand
	[[yoconsole.log(<c-r>0);<left><left><esc>]],
	opts
)

vim.api.nvim_buf_set_keymap(
	buffer,
	"n", -- mode
	"<leader>dd", -- shorthand
	[[yiwoconsole.log(<c-r>0);<left><left><esc>]],
	opts
)
