lua <<EOF
require('lualine').setup {
  sections = {
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
