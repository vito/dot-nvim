lua <<EOF
local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function _G.vito_lsp_on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

local lspconfigs = require 'lspconfig.configs'

if not lspconfigs.golangcilsp then
 	lspconfigs.golangcilsp = {
		default_config = {
			cmd = {'golangci-lint-langserver'},
			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
			init_options = {
        command = { "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1" };
			}
		};
	}
end

if not lspconfigs.templ then
  lspconfigs.templ = {
    default_config = {
      cmd = {"templ", "lsp"},
      filetypes = {'templ'},
      root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
      settings = {},
    };
  }
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- yarn global add vscode-css-languageserver-bin dockerfile-language-server-nodejs elm elm-test elm-format @elm-tooling/elm-language-server vscode-html-languageserver-bin yaml-language-server typescript typescript-language-server
-- https://github.com/hashicorp/terraform-ls/releases/download/v0.17.1/terraform-ls_0.17.1_linux_amd64.zip
local servers = { "cssls", "dockerls", "elmls", "html", "terraformls", "bass", "pylsp", "sorbet", "tsserver", "rnix", "sqlls", "templ", "gopls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = _G.vito_lsp_on_attach
  }
end

lspconfig.pylsp.setup {
  on_attach = _G.vito_lsp_on_attach,
	settings = {
		pylsp = {
			plugins = {
				ruff = {
					enabled = true,
					extendSelect = { "I" },
				},
			}
		}
	},
}

lspconfig.elixirls.setup {
  on_attach = _G.vito_lsp_on_attach,
  cmd = { "elixir-ls" }
}

lspconfig.golangci_lint_ls.setup {
	filetypes = { 'go', 'gomod' }
}

require'fzf_lsp'.setup()
EOF
