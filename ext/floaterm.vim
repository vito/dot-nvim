let g:floaterm_shell='fish'
let g:floaterm_borderchars='─│─│╭╮╯╰'
let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_giteditor=v:false

nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>


highlight! link FloatermBorder Comment
