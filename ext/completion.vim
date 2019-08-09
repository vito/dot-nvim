" use <c-space> to manually trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" use tab to trigger completion, but only if the menu is open or if there's a
" partial word typed
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use shift-tab to go to previous selection
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" enter closes options if present and inserts linebreak
"
" apparently it has to be this complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
