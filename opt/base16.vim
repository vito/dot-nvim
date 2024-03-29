" source this in ~/.nvimrc-colors.local to use base16

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

local base16 = {
  normal = {
    a = { fg = base16_colors.base00, bg = base16_colors.base0B, gui = 'bold' },
    b = { fg = base16_colors.base05, bg = base16_colors.base02 },
    c = { fg = base16_colors.base04, bg = base16_colors.base01 },
  },
  insert = {
    a = { fg = base16_colors.base00, bg = base16_colors.base08, gui = 'bold' },
    b = { fg = base16_colors.base05, bg = base16_colors.base02 },
    c = { fg = base16_colors.base04, bg = base16_colors.base01 },
  },
  visual = {
    a = { fg = base16_colors.base00, bg = base16_colors.base09, gui = 'bold' },
    b = { fg = base16_colors.base05, bg = base16_colors.base02 },
    c = { fg = base16_colors.base04, bg = base16_colors.base01 },
  },
  replace = {
    a = { fg = base16_colors.base00, bg = base16_colors.base08, gui = 'bold' },
    b = { fg = base16_colors.base05, bg = base16_colors.base02 },
    c = { fg = base16_colors.base04, bg = base16_colors.base01 },
  },
  inactive = {
    a = { fg = base16_colors.base04, bg = base16_colors.base01, gui = 'bold' },
    b = { fg = base16_colors.base05, bg = base16_colors.base02 },
    c = { fg = base16_colors.base04, bg = base16_colors.base01 },
  },
}

require('lualine').setup {
  options = {
    theme = base16
  }
}
EOF

" annoying!
hi DiagnosticUnderlineWarn none
