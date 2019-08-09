" taken from vim-one readme and stripped down
if empty($TMUX)
  if has("termguicolors")
    set termguicolors
  endif
endif

" allow use of italic text
let g:one_allow_italics = 1

" set colors
colorscheme one
set background=dark

" utility for colorscheme development
function! SyntaxItem()
  return "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
" set statusline=%{SyntaxItem()}
