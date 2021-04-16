" show all diagnostics
nnoremap <silent> <leader>cd  :<C-u>CocFzfList diagnostics<cr>

" manage extensions
nnoremap <silent> <leader>ce  :<C-u>CocFzfList extensions<cr>

" show commands
nnoremap <silent> <leader>cc  :<C-u>CocFzfList commands<cr>

" find symbol of current document
nnoremap <silent> <leader>co  :<C-u>CocFzfList outline<cr>

" search workspace symbols
nnoremap <silent> <leader>cs  :<C-u>CocFzfList -I symbols<cr>

" resume latest coc list
nnoremap <silent> <leader>cp  :<C-u>CocFzfListResume<CR>

" fast file/mru switching
nnoremap <silent> <leader>cf  :<C-u>CocList files<cr>
nnoremap <silent> <leader>cm  :<C-u>CocList mru<cr>
nnoremap <silent> <C-p>       :<C-u>CocList files<cr>
nnoremap <silent> <C-u>       :<C-u>CocList mru<cr>

" live grep (Ag/Ack/Grep replacement)
nnoremap <silent> <leader>cg  :<C-u>CocList grep<cr>
nnoremap <silent> <leader>cG  :<C-u>CocSearch<space>
