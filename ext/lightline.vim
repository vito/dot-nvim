" no point showing the mode twice
set noshowmode

let s:base00 = [ '#' . g:base16_gui00,  0 ] " black
let s:base01 = [ '#' . g:base16_gui01, 18 ]
let s:base02 = [ '#' . g:base16_gui02, 19 ]
let s:base03 = [ '#' . g:base16_gui03,  8 ]
let s:base04 = [ '#' . g:base16_gui04, 20 ]
let s:base05 = [ '#' . g:base16_gui05,  7 ]
let s:base06 = [ '#' . g:base16_gui06, 21 ]
let s:base07 = [ '#' . g:base16_gui07, 15 ] " white

let s:base08 = [ '#' . g:base16_gui08,  1 ] " red
let s:base09 = [ '#' . g:base16_gui09, 16 ] " orange
let s:base0A = [ '#' . g:base16_gui0A,  3 ] " yellow
let s:base0B = [ '#' . g:base16_gui0B,  2 ] " green
let s:base0C = [ '#' . g:base16_gui0C,  6 ] " teal
let s:base0D = [ '#' . g:base16_gui0D,  4 ] " blue
let s:base0E = [ '#' . g:base16_gui0E,  5 ] " pink
let s:base0F = [ '#' . g:base16_gui0F, 17 ] " brown

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:base00, s:base0B ], [ s:base05, s:base02 ] ]
let s:p.insert.left     = [ [ s:base00, s:base08 ], [ s:base05, s:base02 ] ]
let s:p.visual.left     = [ [ s:base00, s:base09 ], [ s:base05, s:base02 ] ]
let s:p.replace.left    = [ [ s:base00, s:base08 ], [ s:base05, s:base02 ] ]
let s:p.inactive.left   = [ [ s:base04, s:base01 ] ]

let s:p.normal.middle   = [ [ s:base04, s:base01 ] ]
let s:p.inactive.middle = [ [ s:base03, s:base01 ] ]

let s:p.normal.right    = [ [ s:base05, s:base03 ], [ s:base05, s:base02 ] ]
let s:p.inactive.right  = [ [ s:base03, s:base01 ] ]

let s:p.normal.error    = [ [ s:base07, s:base08 ] ]
let s:p.normal.warning  = [ [ s:base07, s:base09 ] ]

let s:p.tabline.left    = [ [ s:base05, s:base02 ] ]
let s:p.tabline.middle  = [ [ s:base05, s:base01 ] ]
let s:p.tabline.right   = [ [ s:base05, s:base02 ] ]
let s:p.tabline.tabsel  = [ [ s:base02, s:base0A ] ]

let g:lightline#colorscheme#base16#palette = lightline#colorscheme#flatten(s:p)

command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" configure lightline
let g:lightline = {
      \   'colorscheme': 'base16',
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'],
      \       ['readonly', 'filename'],
      \       ['fugitive']
      \     ],
      \     'right': [
      \       ['lineinfo'],
      \       ['percent'],
      \       ['filetype']
      \     ],
      \   },
      \   'inactive': {
      \     'left': [
      \       ['readonly', 'filename'],
      \       ['fugitive']
      \     ],
      \     'right': [
      \       ['lineinfo'],
      \       ['percent'],
      \       ['filetype'],
      \     ]
      \   },
      \   'component_function': {
      \     'readonly': 'LightlineReadonly',
      \     'fugitive': 'FugitiveHead',
      \     'filename': 'LightlineFilename'
      \   },
      \   'component': {}
      \ }

" lightline helpers

function! LightlineFilename()
  let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
