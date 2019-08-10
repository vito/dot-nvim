let g:lightline = {
      \   'colorscheme': 'one',
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
      \     ]
      \   },
      \   'component_function': {
      \     'cocstatus': 'coc#status',
      \     'currentfunction': 'CocCurrentFunction',
      \     'readonly': 'LightlineReadonly',
      \     'fugitive': 'LightlineFugitive'
      \   },
      \   'component': {
      \     'lineinfo': '%3l:%-2v',
      \   },
      \   'separator':    { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' }
      \ }

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
