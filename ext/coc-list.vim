" show all diagnostics
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>

" manage extensions
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>

" show commands
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" find symbol of current document
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>

" search workspace symbols
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" resume latest coc list
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>

" fast file/mru switching
nnoremap <silent> <leader>cf  :<C-u>CocList files<cr>
nnoremap <silent> <leader>cm  :<C-u>CocList mru<cr>

" live grep (Ag/Ack/Grep replacement)
nnoremap <silent> <leader>cg  :<C-u>CocList grep<cr>
nnoremap <silent> <leader>cG  :<C-u>CocSearch<space>
