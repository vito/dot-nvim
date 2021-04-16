let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_cursor_line_number_background = 1

" set colors to match base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" utility for colorscheme development
function! SyntaxItem()
  return "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
" set statusline=%{SyntaxItem()}
