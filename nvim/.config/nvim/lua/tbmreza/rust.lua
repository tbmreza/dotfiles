-- move to ROOT/ftplugin?
vim.cmd [[
  function! FiletypeRust()
    nmap <leader>f :RustFmt<cr>
    nnoremap <leader>dd yeoprintln!("{:?}", <c-r>0);<esc>
    inoremap # #[]<left>
  endfunction
  autocmd filetype rust call FiletypeRust()
]]
