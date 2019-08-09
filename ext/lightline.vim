function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
\   'colorscheme': 'one',
\   'active': {
\     'left': [
\       ['mode', 'paste'],
\       ['cocstatus', 'currentfunction', 'readonly', 'filename', 'modified']
\     ]
\   },
\   'component_function': {
\     'cocstatus': 'coc#status',
\     'currentfunction': 'CocCurrentFunction'
\   },
\ }

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
