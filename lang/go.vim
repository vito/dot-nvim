autocmd! BufEnter *.go setlocal noexpandtab

lua <<EOF
function go_organize_imports_sync(timeout_ms)
  vim.lsp.buf.formatting_sync(nil, 1000)

  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result then return end
  result = result[1].result
  if not result then return end
  edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
end

vim.api.nvim_command("au BufWritePre *.go lua go_organize_imports_sync(1000)")
EOF
