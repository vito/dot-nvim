lua <<EOF
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

configs.bass = {
  default_config = {
    cmd = { 'bass-lsp' },
    root_dir = util.root_pattern('.git'),
    filetypes = { 'clojure' }
  },

  docs = {
    description = [[https://github.com/vito/bass]],
  },
};
EOF

autocmd! BufEnter *.bass setlocal ft=clojure lispwords+=job,def,op,defop,defn,defcmd,provide
