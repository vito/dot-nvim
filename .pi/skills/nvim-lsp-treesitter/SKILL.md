---
name: nvim-lsp-treesitter
description: Add and configure LSP language servers and Tree-sitter grammars in Neovim 0.12+. Use when enabling a new language, adding an LSP server, installing Tree-sitter parsers, or configuring language-specific features. Triggers on "add language", "LSP server", "tree-sitter", "language support", "new filetype".
---

# Adding Language Support (LSP + Tree-sitter)

This config uses Neovim 0.12's built-in LSP support with `nvim-lspconfig`
for convenience, and `nvim-treesitter` for grammar installation. Both are
installed in `plugin/40_plugins.lua`.

## LSP: Adding a new language server

### 1. Install the server binary

The language server must be available on `$PATH`. Install it using your
system package manager, language toolchain, or Mason (which is installed in
this config). Examples:

```sh
# Go
go install golang.org/x/tools/gopls@latest
# Rust
rustup component add rust-analyzer
# TypeScript
npm install -g typescript-language-server typescript
# Lua (for Neovim config)
brew install lua-language-server  # or your OS equivalent
# Or use Mason inside Neovim:
# :MasonInstall lua-language-server
```

### 2. Add a server config in `after/lsp/`

Create a file at `after/lsp/<server_name>.lua` that returns a config table.
This is the MiniMax pattern — see `after/lsp/lua_ls.lua` for an example.

```lua
-- after/lsp/gopls.lua
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', '.git' },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
}
```

Key fields:
- `cmd`: command to start the server (must be on `$PATH`)
- `filetypes`: which filetypes trigger attachment
- `root_markers`: files/dirs that identify the project root
- `settings`: server-specific configuration
- `on_attach`: function(client, buf_id) for buffer-local setup

### 3. Enable the server

In `plugin/40_plugins.lua`, find the `vim.lsp.enable()` call (inside the
LSP section's `now_if_args` block) and add the server name:

```lua
vim.lsp.enable({ 'lua_ls', 'gopls' })
```

If there is no `vim.lsp.enable()` call yet (it starts commented out),
uncomment it and add your server names.

### Default LSP keymaps

Neovim 0.12 maps these by default when an LSP client attaches:

| Key       | Action                          |
|-----------|---------------------------------|
| `grn`     | Rename symbol                   |
| `gra`     | Code action                     |
| `grr`     | References                      |
| `gri`     | Implementations                 |
| `grt`     | Type definition                 |
| `grx`     | Run code lens                   |
| `gO`      | Document symbols                |
| `gq`      | Format (uses LSP if available)  |
| `K`       | Hover                           |
| `[d`/`]d` | Prev/next diagnostic            |

This config also defines `<Leader>l` mappings in `plugin/20_keymaps.lua`
as structured alternatives (since `gr` is used by mini.operators):

| Key           | Action              |
|---------------|---------------------|
| `<Leader>la`  | Code action         |
| `<Leader>ld`  | Diagnostic popup    |
| `<Leader>lf`  | Format (conform)    |
| `<Leader>lh`  | Hover               |
| `<Leader>li`  | Implementation      |
| `<Leader>ll`  | Code lens           |
| `<Leader>lr`  | Rename              |
| `<Leader>lR`  | References          |
| `<Leader>ls`  | Source definition    |
| `<Leader>lt`  | Type definition     |

## Tree-sitter: Adding a grammar

### Add the language to the languages table

In `plugin/40_plugins.lua`, find the `languages` table inside the
tree-sitter `now_if_args` block and add your language:

```lua
local languages = {
  'lua',
  'vimdoc',
  'markdown',
  -- Add new languages here
  'go',
  'rust',
  'typescript',
}
```

The config automatically:
1. Checks which parsers aren't installed yet
2. Installs missing ones via `require('nvim-treesitter').install()`
3. Creates a `FileType` autocommand to call `vim.treesitter.start()` for
   those filetypes

Restart Neovim once after adding languages. Wait for parser installation
to finish before opening files for the new language(s).

The `Config.on_packchanged()` hook at the top of the tree-sitter section
runs `:TSUpdate` automatically when `nvim-treesitter` is updated.

### Manual grammar installation

For one-off installs without editing config:

```vim
:TSInstall go rust typescript
```

### Treesitter incremental selection (built-in)

Works in visual mode with no config needed:

| Key  | Action                |
|------|-----------------------|
| `an` | Expand to parent node |
| `in` | Shrink to child node  |
| `]n` | Next sibling          |
| `[n` | Previous sibling      |

## Checklist for adding a new language

1. Install the language server binary and ensure it's on `$PATH`
   (or install via `:MasonInstall <server>`).
2. Create `after/lsp/<server_name>.lua` with the server config (see
   `after/lsp/lua_ls.lua` for the pattern).
3. Add the server name to `vim.lsp.enable()` in `plugin/40_plugins.lua`.
4. Add the language to the `languages` table in the tree-sitter section
   of `plugin/40_plugins.lua`.
5. Restart Neovim and wait for parser installation.
6. Verify: open a file, run `:checkhealth vim.lsp` and `:Inspect`.
7. Commit config changes and `nvim-pack-lock.json`.
