-- move to ROOT/ftplugin?
vim.cmd([[
  function! FiletypeRust()
    nmap <leader>f :RustFmt<cr>
    nnoremap <leader>dd yeoprintln!("{:?}", <c-r>0);<esc>
  endfunction
  autocmd filetype rust call FiletypeRust()
]])

-- local rt = require("rust-tools")
--
-- local extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.8.1/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
--
-- rt.setup({
--   server = {
--     on_attach = function(_, bufnr)
--       -- Hover actions
--       vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--       -- Code action groups
--       vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
--   dap = {
--     adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
--   }
-- })
