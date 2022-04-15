let g:floaterm_shell='fish'

nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_borderchars='─│─│╭╮╯╰'

highlight! link FloatermBorder Comment

autocmd FileType floaterm setlocal winblend=10
