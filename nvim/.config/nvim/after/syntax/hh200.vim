" Syntax highlighting for hh200 files
if exists("b:current_syntax")
  finish
endif

" Add your syntax rules here - examples:
" ?? merge with auto generated
syn keyword hh200Keyword def GET POST
syn keyword hh200Type int string bool float
syn match hh200Comment "#.*$"
syn region hh200String start='"' end='"'

" Link to standard highlighting groups
hi def link hh200Keyword Keyword
hi def link hh200Type Type
hi def link hh200Comment Comment
hi def link hh200String String

let b:current_syntax = "hh200"
