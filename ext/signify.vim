" always show sign column to prevent jumping
set signcolumn=yes

" default updatetime 4000ms is not good for async update
set updatetime=100

" cooler indicators
let g:signify_sign_add               = '░'
let g:signify_sign_change            = '░'
let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_delete            = '▁'
let g:signify_sign_change_delete     = g:signify_sign_change . g:signify_sign_delete_first_line
