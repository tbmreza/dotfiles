local buffer = 0 -- current buffer
local opts = { noremap = true, silent = true }

vim.api.nvim_buf_set_keymap(
	buffer,
	"v", -- mode
	"<leader>dd", -- shorthand
	[[yolog.Println("<c-r>0:\n", <c-r>0)<left><left><esc>]],
	opts
)

vim.api.nvim_buf_set_keymap(
	buffer,
	"n", -- mode
	"<leader>dd", -- shorthand
	[[yiwolog.Println("<c-r>0:\n", <c-r>0)<left><left><esc>]],
	opts
)
