" no point showing the mode twice
set noshowmode

" configure lightline
let g:lightline = {
      \   'colorscheme': 'nord',
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'],
      \       ['readonly', 'relativepath', 'modified'],
      \       ['currentfunction', 'cocstatus']
      \     ],
      \     'right': [
      \       ['lineinfo'],
      \       ['percent'],
      \       ['filetype']
      \     ],
      \   },
      \   'inactive': {
      \     'left': [
      \       ['readonly', 'relativepath', 'modified'],
      \       ['currentfunction', 'cocstatus']
      \     ],
      \     'right': [
      \       ['lineinfo'],
      \       ['percent'],
      \       ['filetype']
      \     ]
      \   },
      \   'component_function': {
      \     'cocstatus': 'coc#status',
      \     'currentfunction': 'CocCurrentFunction',
      \     'readonly': 'LightlineReadonly',
      \     'fugitive': 'LightlineFugitive'
      \   },
      \   'component': {}
      \ }

" lightline helpers

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction
