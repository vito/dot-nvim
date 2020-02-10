autocmd! BufEnter *.go setlocal noexpandtab

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
