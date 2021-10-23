" enable 24-bit RGB color, for components (e.g. lualine) which primarly set
" guifg to hex values
set termguicolors

" set colors to match base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
