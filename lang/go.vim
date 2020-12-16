autocmd! BufEnter *.go setlocal noexpandtab

autocmd BufWritePre *.go :call CocAction('organizeImport')
