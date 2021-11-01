lua <<EOF
require('lualine').setup {
  sections = {
    lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp', 'ale'}}},
    lualine_c = {
      {
        'filename',
        path = 1 -- relative path
      }
    }
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        path = 1 -- relative path
      }
    }
  },
  options = {
    icons_enabled = false
  }
}
EOF
