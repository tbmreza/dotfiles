-- move to ROOT/ftplugin?
vim.cmd([[
  function! FiletypeRust()
    nmap <leader>f :RustFmt<cr>
    nnoremap <leader>dd yeoprintln!("{:?}", <c-r>0);<esc>
  endfunction
  autocmd filetype rust call FiletypeRust()
]])
