" enable 24-bit RGB color, for components (e.g. lualine) which primarly set
" guifg to hex values
set termguicolors

set background=dark
colorscheme tokyonight

lua <<EOF
vim.g.tokyonight_lualine_bold = true

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}
EOF

" base16 config follows; not using it anymore since there's a more appropriate
" theme plugin, but don't want to just comment it all out, so just bail
finish

" set colors to match base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

lua <<EOF
local base16_colors = {
  base00 = '#' .. vim.g.base16_gui00, -- black
  base01 = '#' .. vim.g.base16_gui01,
  base02 = '#' .. vim.g.base16_gui02,
  base03 = '#' .. vim.g.base16_gui03,
  base04 = '#' .. vim.g.base16_gui04,
  base05 = '#' .. vim.g.base16_gui05,
  base06 = '#' .. vim.g.base16_gui06,
  base07 = '#' .. vim.g.base16_gui07, -- white
  base08 = '#' .. vim.g.base16_gui08, -- red
  base09 = '#' .. vim.g.base16_gui09, -- orange
  base0A = '#' .. vim.g.base16_gui0A, -- yellow
  base0B = '#' .. vim.g.base16_gui0B, -- green
  base0C = '#' .. vim.g.base16_gui0C, -- teal
  base0D = '#' .. vim.g.base16_gui0D, -- blue
  base0E = '#' .. vim.g.base16_gui0E, -- pink
  base0F = '#' .. vim.g.base16_gui0F, -- brown
}

local theme = {
  normal = {
    a = { fg = colors.base00, bg = colors.base0B, gui = 'bold' },
    b = { fg = colors.base05, bg = colors.base02 },
    c = { fg = colors.base04, bg = colors.base01 },
  },
  insert = {
    a = { fg = colors.base00, bg = colors.base08, gui = 'bold' },
    b = { fg = colors.base05, bg = colors.base02 },
    c = { fg = colors.base04, bg = colors.base01 },
  },
  visual = {
    a = { fg = colors.base00, bg = colors.base09, gui = 'bold' },
    b = { fg = colors.base05, bg = colors.base02 },
    c = { fg = colors.base04, bg = colors.base01 },
  },
  replace = {
    a = { fg = colors.base00, bg = colors.base08, gui = 'bold' },
    b = { fg = colors.base05, bg = colors.base02 },
    c = { fg = colors.base04, bg = colors.base01 },
  },
  inactive = {
    a = { fg = colors.base04, bg = colors.base01, gui = 'bold' },
    b = { fg = colors.base05, bg = colors.base02 },
    c = { fg = colors.base04, bg = colors.base01 },
  },
}

require('lualine').setup {
  options = {
    theme = base16
  }
}
EOF
