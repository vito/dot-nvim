autocmd! BufEnter *.go setlocal noexpandtab

" fix conflict with <Ctrl+T>; LSP provides go-to-definition anyway
let g:go_def_mapping_enabled = 0
