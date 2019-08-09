" add cursor here
nmap <silent> <C-c> <Plug>(coc-cursors-position)

" add cursor for word/selection and go to next
nmap <silent> <C-d> <Plug>(coc-cursors-word)*
xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn

" use normal command like `<leader>xi(`
nmap <leader>x  <Plug>(coc-cursors-operator)

" give multi-cursors a more obvious color
"
" these are just taken from their docs, not adjusted to match the theme
"
" for some reason this only works if I have it run when a buffer is opened :|
"
" it worked for a while but then stopped taking precedence no matter where i
" put it.
"
" idk.
autocmd! BufEnter * hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
