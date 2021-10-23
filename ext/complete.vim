set completeopt=menu,menuone,noselect

lua <<EOF
local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }
  }, {
    { name = 'buffer' },
  }),
  experimental = {
    ghost_text = true
  }
})
EOF
