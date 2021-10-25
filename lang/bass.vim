lua <<EOF
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

configs.bass = {
  default_config = {
    cmd = { 'bass-lsp' },
    root_dir = util.root_pattern('.git'),
    filetypes = { 'bass' }
  },

  docs = {
    description = [[https://github.com/vito/bass]],
  },
};
EOF
