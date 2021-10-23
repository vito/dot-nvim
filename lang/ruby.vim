lua <<EOF
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

configs.sorbet = {
  default_config = {
    cmd = { "sorbet-lsp" }; -- exercise left to the reader
    filetypes = {"ruby"};
    root_dir = util.root_pattern(".git");
  };
};
EOF

autocmd! BufEnter *.rbi setlocal ft=ruby
