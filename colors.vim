" enable 24-bit RGB color, for components (e.g. lualine) which primarly set
" guifg to hex values
set termguicolors

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" source local colors config if any
if !empty(glob("~/.nvimrc-colors.local"))
  source ~/.nvimrc-colors.local
else
  set background=dark
  colorscheme rose-pine
endif
