---
name: nvim-packages
description: Install, update, and remove Neovim plugins using the built-in vim.pack package manager (Neovim 0.12+). Use when adding a new plugin, updating plugins, pinning versions, removing packages, or troubleshooting vim.pack issues. Triggers on "install plugin", "add package", "vim.pack", "update plugins", "remove plugin".
---

# Neovim Package Management with vim.pack

This config uses Neovim 0.12's built-in `vim.pack` module. No external plugin
manager is needed.

## Config layout

The config lives at `~/.config/nvim`. Files in `plugin/` are sourced
automatically during startup in alphabetical order — numeric prefixes
control load order.

```
~/.config/nvim/
├── init.lua                  # Sets up _G.Config, loads mini.nvim, defines
│                             # loading helpers (now/later/on_event/etc.)
├── plugin/                   # Each file sourced automatically at startup
│   ├── 10_options.lua        # Built-in Neovim behavior, leader key
│   ├── 20_keymaps.lua        # Custom mappings
│   ├── 30_mini.lua           # MINI module configuration
│   └── 40_plugins.lua        # Plugins outside of MINI
├── after/
│   ├── lsp/                  # LSP server configs (e.g. lua_ls.lua)
│   ├── ftplugin/             # Filetype-specific overrides
│   └── snippets/             # Higher priority snippet files
├── snippets/                 # User-defined snippets
└── nvim-pack-lock.json       # Auto-managed lockfile (commit this)
```

## Loading helpers

`init.lua` defines safe loading helpers on `_G.Config`. **Always wrap
plugin installation and configuration in one of these:**

- `Config.now(f)` — execute immediately. Use for things needed at first
  draw: colorschemes, statusline, tabline.
- `Config.later(f)` — execute after first draw. Use for everything else.
- `Config.now_if_args(f)` — execute immediately if Neovim was started with
  file arguments (`nvim -- file`), otherwise defers like `later()`.
- `Config.on_event(ev, f)` — execute once on first matched event.
- `Config.on_filetype(ft, f)` — execute once on first matched filetype.

A local shorthand is used in plugin files:

```lua
local add = vim.pack.add
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later
```

## Installing a plugin

Use `vim.pack.add()` inside a loading helper in `plugin/40_plugins.lua`
(or a new `plugin/*.lua` file). Sources **must** be full URLs.

### Basic pattern

```lua
later(function()
  add({ 'https://github.com/user/repo' })
  require('repo').setup({ ... })
end)
```

### Needed at startup (e.g. colorscheme)

```lua
Config.now(function()
  add({ 'https://github.com/user/colorscheme', name = 'colorscheme' })
  vim.cmd('color colorscheme')
end)
```

### Needed only when opening files

```lua
now_if_args(function()
  add({ 'https://github.com/user/repo' })
  require('repo').setup()
end)
```

### Pin to a branch, tag, or commit

```lua
add({
  { src = 'https://github.com/user/repo', version = 'main' },
})
```

### Pin to a semver range

```lua
add({
  { src = 'https://github.com/user/repo', version = vim.version.range('2.x') },
})
```

### Multiple plugins in one call

```lua
add({
  'https://github.com/user/repo-a',
  'https://github.com/user/repo-b',
  { src = 'https://github.com/user/repo-c', version = 'stable' },
})
```

## Updating plugins

There is no auto-update. Run interactively:

- **Update all:** `:lua vim.pack.update()`
- **Update one:** `:lua vim.pack.update({ 'plugin-name' })`
- **Force (skip confirmation):** `:lua vim.pack.update(nil, { force = true })`
- **Revert to lockfile:** `:lua vim.pack.update(nil, { target = 'lockfile' })`
- **Inspect without fetching:** `:lua vim.pack.update(nil, { offline = true })`

The confirmation buffer supports `]]`/`[[` to navigate sections, LSP hover
for commit details, and code actions to skip/accept individual updates.
Write (`:w`) to apply, quit (`:q`) to abort.

### Lockfile

`nvim-pack-lock.json` records the exact commit for every managed plugin.
**Commit this file to version control.** On a fresh machine, `vim.pack.add()`
automatically installs everything to the lockfile's recorded state.

To revert an update: restore the old lockfile from git, then run
`:lua vim.pack.update(nil, { target = 'lockfile' })`.

## Removing a plugin

Two steps, both required:

1. Remove or comment out the `vim.pack.add()` call from the config.
2. Delete from disk: `:lua vim.pack.del({ 'plugin-name' })`

**Never** delete the plugin directory by hand — that won't update the
lockfile and the plugin will be reinstalled on next startup.

## Hooks (post-install / post-update actions)

Use `Config.on_packchanged()` **before** the `vim.pack.add()` call.
Define hooks in `init.lua` or early in the relevant `plugin/*.lua` file.

```lua
-- In plugin/40_plugins.lua, before the add() call
Config.on_packchanged('nvim-treesitter', { 'update' }, function()
  vim.cmd('TSUpdate')
end, ':TSUpdate')
```

Hook kinds: `install` (first time), `update` (subsequent), `delete`.

## Deferred loading

Use the loading helpers instead of raw autocommands:

```lua
-- Load after first draw
Config.later(function()
  add({ 'https://github.com/user/plugin' })
  require('plugin').setup()
end)

-- Load on first event
Config.on_event('InsertEnter', function()
  add({ 'https://github.com/user/completion-plugin' })
  require('completion-plugin').setup()
end)

-- Load on first filetype match
Config.on_filetype('lua', function()
  add({ 'https://github.com/user/lua-plugin' })
  require('lua-plugin').setup()
end)
```

## Troubleshooting

Run `:checkhealth vim.pack` to detect lockfile mismatches, missing plugins,
and inactive (installed but not loaded) plugins.

## Quick checklist for adding a plugin

1. **Read the plugin's README first** — fetch it with
   `gh api repos/OWNER/REPO/readme --jq '.content' | base64 -d` to learn
   about dependencies, required setup calls, build steps, and config options.
2. Decide which loading stage it needs (`now`, `later`, `now_if_args`).
3. Add it in `plugin/40_plugins.lua` (or a new `plugin/*.lua` file) wrapped
   in the appropriate `Config.*` helper with `add()` + config inside.
4. If it needs a post-install/update hook, add a `Config.on_packchanged()`
   call before the `add()`.
5. Restart Neovim — confirm the install prompt.
6. Commit both the changed config file and `nvim-pack-lock.json`.
