---
name: nvim-keymaps
description: Add keymaps for Neovim 0.12 built-in features and plugins. Use when adding key bindings, mapping new built-in commands like Undotree or DiffTool, or configuring leader key shortcuts. Triggers on "keymap", "keybind", "mapping", "shortcut", "Undotree", "DiffTool", "leader".
---

# Neovim Keymaps

Keymaps live in `~/.config/nvim/plugin/20_keymaps.lua`. Plugin-specific
keymaps can also go alongside the plugin config in its `plugin/*.lua` file.

## Conventions

- **Leader key**: `,` — set in `plugin/10_options.lua` as `vim.g.mapleader`.
- Use `<Leader>` prefixed maps for workflow actions.
- Two-key leader pattern: first key = semantic group, second = action.
  Example: `<Leader>f` = "find", `<Leader>ff` = find files.
- Lowercase second key = global scope, uppercase = local/buffer scope.
  Example: `<Leader>fs`/`<Leader>fS` = workspace/document symbols.
- Use `desc` for every mapping — it shows in `mini.clue` and `:map` output.

## Leader group registration

When adding a new leader group, register it in `Config.leader_group_clues`
(defined in `plugin/20_keymaps.lua`) so `mini.clue` shows it:

```lua
Config.leader_group_clues = {
  -- existing groups...
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  -- add new groups here
  { mode = 'n', keys = '<Leader>x', desc = '+MyGroup' },
}
```

## Mapping helpers

`plugin/20_keymaps.lua` defines concise helpers:

```lua
-- Simple Normal mode map
local nmap = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

-- Leader mappings (Normal and Visual)
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end
```

Use these when adding new leader mappings to `20_keymaps.lua`:

```lua
nmap_leader('xa', '<Cmd>SomeCommand<CR>', 'My action')
```

## Existing leader groups

| Prefix       | Group             | Examples                              |
|--------------|-------------------|---------------------------------------|
| `<Leader>b`  | Buffer            | `bs` scratch, `bw` wipeout           |
| `<Leader>e`  | Explore/Edit      | `ed` directory, `ef` file dir         |
| `<Leader>f`  | Find (mini.pick)  | `ff` files, `fg` grep, `fh` help     |
| `<Leader>g`  | Git               | `gs` show, `gd` diff, `go` overlay   |
| `<Leader>l`  | Language (LSP)    | `la` action, `lr` rename, `ls` def   |
| `<Leader>m`  | Map (mini.map)    | `mt` toggle, `mf` focus              |
| `<Leader>o`  | Other             | `oz` zoom, `ot` trim trailspace      |
| `<Leader>s`  | Session           | `sn` new, `sr` read, `sd` delete     |
| `<Leader>t`  | Terminal          | `tt` vertical, `tT` horizontal       |
| `<Leader>v`  | Visits            | `vv` add core, `vc` pick core        |

## Built-in Neovim 0.12 features worth mapping

### Undotree (built-in plugin)

`:Undotree` opens an interactive undo tree browser. No plugin needed.

```lua
nmap_leader('u', '<Cmd>Undotree<CR>', 'Undo tree')
```

### DiffTool (built-in plugin)

`:DiffTool` compares directories and files.

```lua
nmap_leader('dD', function()
  vim.ui.input({ prompt = 'DiffTool path: ' }, function(path)
    if path then vim.cmd('DiffTool ' .. vim.fn.fnameescape(path)) end
  end)
end, 'Diff directory/file')
```

### LSP (defaults already provided)

Neovim 0.12 maps these by default when an LSP client attaches:

| Key       | Action              |
|-----------|---------------------|
| `grn`     | Rename              |
| `gra`     | Code action         |
| `grr`     | References          |
| `gri`     | Implementations     |
| `grt`     | Type definition     |
| `grx`     | Code lens run       |
| `gO`      | Document symbols    |
| `K`       | Hover               |

This config also provides `<Leader>l` alternatives in `20_keymaps.lua`
(because `gr` is used by mini.operators for the replace operator).

### Treesitter incremental selection (built-in)

Works in visual mode with no config needed:

| Key  | Action                |
|------|-----------------------|
| `an` | Expand to parent node |
| `in` | Shrink to child node  |
| `]n` | Next sibling          |
| `[n` | Previous sibling      |

## Pattern: mapping a built-in command

```lua
nmap_leader('KEY', '<Cmd>COMMAND<CR>', 'Description')
```

## Pattern: mapping a Lua function

```lua
nmap_leader('KEY', function()
  -- lua code
end, 'Description')
```

## Pattern: buffer-local maps (for filetype or plugin)

```lua
vim.keymap.set('n', '<Leader>KEY', action, { buffer = bufnr, desc = 'Description' })
```

Or in a filetype plugin (`after/ftplugin/<filetype>.lua`):

```lua
vim.keymap.set('n', '<Leader>gt', '<Cmd>!go test ./...<CR>', {
  buffer = 0,
  desc = 'Go test',
})
```

Or via autocommand:

```lua
Config.new_autocmd('FileType', 'go', function(ev)
  vim.keymap.set('n', '<Leader>gt', '<Cmd>!go test ./...<CR>', {
    buffer = ev.buf,
    desc = 'Go test',
  })
end, 'Go test mapping')
```
