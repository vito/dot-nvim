-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- File explorer ==============================================================

-- Editable file explorer buffers, like vim-vinegar.
-- Example usage:
-- - `-` - open parent directory
Config.now(function()
  add({ 'https://github.com/stevearc/oil.nvim' })
  require('oil').setup()
  vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open parent directory' })
end)

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
-- - In case of errors related to queries for Neovim bundled parsers (like `lua`,
--   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
--   with `:TSInstall <language>`. Be sure to have necessary system dependencies
--   (see MiniMax README section for software requirements).
now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  -- Define languages which will have parsers installed and auto enabled
  -- After changing this, restart Neovim once to install necessary parsers. Wait
  -- for the installation to finish before opening a file for added language(s).
  local languages = {
    -- These are already pre-installed with Neovim. Used as an example.
    'lua',
    'vimdoc',
    'markdown',
    -- Add here more languages with which you want to use tree-sitter
    -- To see available languages:
    -- - Execute `:=require('nvim-treesitter').get_available()`
    -- - Visit 'SUPPORTED_LANGUAGES.md' file at
    --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
    'bash',
    'css',
    'elixir',
    'fish',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'gosum',
    'gotmpl',
    'gowork',
    'graphql',
    'html',
    'javascript',
    'json',
    'mermaid',
    'php',
    'proto',
    'python',
    'query',
    'ruby',
    'rust',
    'sql',
    'toml',
    'typescript',
    'yaml',
    'zig',
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  -- Use `:h vim.lsp.enable()` to automatically enable language server based on
  -- the rules provided by 'nvim-lspconfig'.
  -- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
  -- Uncomment and tweak the following `vim.lsp.enable()` call to enable servers.
  -- vim.lsp.enable({
  --   -- For example, if `lua-language-server` is installed, use `'lua_ls'` entry
  -- })
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    -- formatters_by_ft = { lua = { 'stylua' } },
  })
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function() add({ 'https://github.com/rafamadriz/friendly-snippets' }) end)

-- Honorable mentions =========================================================

-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
--
-- You can use it like so:
now_if_args(function()
  add({ 'https://github.com/mason-org/mason.nvim' })
  require('mason').setup()
  add({ 'https://github.com/mason-org/mason-lspconfig.nvim' })
  require("mason-lspconfig").setup()
end)

-- Menu ========================================================================

-- Context menu UI for Neovim with nested menu support.
-- Uses 'nvzone/volt' (already installed) as its UI framework.
-- Example usage:
-- - `<C-m>` - open menu via keyboard
-- - `<RightMouse>` - open menu via right-click
later(function()
  add({ 'https://github.com/nvzone/menu' })

  -- Keyboard users
  vim.keymap.set('n', '<C-m>', function()
    require('menu').open('default')
  end, { desc = 'Open menu' })

  -- Mouse users
  vim.keymap.set({ 'n', 'v' }, '<RightMouse>', function()
    require('menu.utils').delete_old_menus()
    vim.cmd.exec('"normal! \\<RightMouse>"')
    require('menu').open('default', { mouse = true })
  end, { desc = 'Open context menu' })
end)

-- Floating terminal ===========================================================

-- Floating terminal window with sidebar for managing multiple terminals.
-- Uses 'nvzone/volt' as its UI framework.
-- Example usage:
-- - `<C-t>` - toggle floating terminal from anywhere
-- - Inside terminal sidebar: `a` to add, `d` to delete, `e` to rename
later(function()
  add({
    { src = 'https://github.com/vito/volt', version = 'theme-refresh-hooks' },
    { src = 'https://github.com/vito/floaterm', version = 'auto-title' },
  })

  require('floaterm').setup({
    mappings = {
      term = function(buf)
        -- Override volt's <Esc> close: return to terminal mode instead
        vim.keymap.set('n', '<Esc>', 'i', { buffer = buf, desc = 'Return to terminal mode' })
        -- Override volt's <C-t> cycle: toggle floaterm instead
        vim.keymap.set('n', '<C-t>', '<Cmd>FloatermToggle<CR>', { buffer = buf, desc = 'Toggle floating terminal' })
      end,
      sidebar = function(buf)
        -- Override volt's <Esc> close: switch to terminal and enter insert mode
        vim.keymap.set('n', '<Esc>', function()
          require('floaterm.api').switch_wins()
          vim.cmd.startinsert()
        end, { buffer = buf, desc = 'Switch to terminal' })
        -- Override volt's <C-t> cycle: toggle floaterm instead
        vim.keymap.set('n', '<C-t>', '<Cmd>FloatermToggle<CR>', { buffer = buf, desc = 'Toggle floating terminal' })
        -- Quick way to enter terminal from sidebar
        vim.keymap.set('n', 'i', function()
          require('floaterm.api').switch_wins()
          vim.cmd.startinsert()
        end, { buffer = buf, desc = 'Enter terminal' })
      end,
    },
  })

  vim.keymap.set({ 'n', 't' }, '<C-t>', '<Cmd>FloatermToggle<CR>', { desc = 'Toggle floating terminal' })
end)

-- Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
-- have full support of its highlight groups. Use if you don't like 'miniwinter'
-- enabled in 'plugin/30_mini.lua' or other suggested 'mini.hues' based ones.
Config.now(function()
  add({ 'https://github.com/rose-pine/neovim' })
  vim.cmd('color rose-pine')
end)

-- Git permalinks ==============================================================

-- Generate shareable git permalinks with line ranges. Default mapping:
-- - `<Leader>gy` (normal/visual) - copy permalink to clipboard
later(function()
  add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/ruifm/gitlinker.nvim',
  })
  require('gitlinker').setup()
end)

-- Git signs & inline blame ====================================================

-- Sign column indicators for git hunks, inline blame, and hunk actions.
-- Note: sign column overlaps with mini.diff; disable one if they conflict.
later(function()
  add({ 'https://github.com/lewis6991/gitsigns.nvim' })
  require('gitsigns').setup({
    current_line_blame = true,
  })
end)

-- Copy file references ========================================================

-- Copy file path and line references to clipboard.
-- - `<Leader>yr` - copy file path
-- - `<Leader>yR` - copy file:line (or file:line-range in visual mode)
later(function()
  add({ 'https://github.com/cajames/copy-reference.nvim' })
  require('copy-reference').setup()
  vim.keymap.set({ 'n', 'x' }, '<Leader>yr', '<Cmd>CopyReference file<CR>', { desc = 'Copy file path' })
  vim.keymap.set({ 'n', 'x' }, '<Leader>yR', '<Cmd>CopyReference line<CR>', { desc = 'Copy file:line reference' })
end)

-- Multicursor =================================================================

-- Multiple cursors with match-based and line-based adding.
-- - `gn`/`gu` - add cursor at next/prev match
-- - `ga` - add cursor at all matches
-- - Arrow up/down - add cursor above/below
-- - `<C-LeftMouse>` - add/remove cursor by click
later(function()
  add({ { src = 'https://github.com/jake-stewart/multicursor.nvim', version = '1.0' } })

  local mc = require('multicursor-nvim')
  mc.setup()

  local set = vim.keymap.set

  -- Zed-style multicursor bindings
  set({ 'n', 'x' }, 'gl', function() mc.matchAddCursor(1) end, { desc = 'Add cursor at next occurrence' })
  set({ 'n', 'x' }, 'gL', function() mc.matchAddCursor(-1) end, { desc = 'Add cursor at prev occurrence' })
  set({ 'n', 'x' }, 'g>', function() mc.matchSkipCursor(1) end, { desc = 'Skip to next occurrence' })
  set({ 'n', 'x' }, 'g<', function() mc.matchSkipCursor(-1) end, { desc = 'Skip to prev occurrence' })
  set({ 'n', 'x' }, 'gn', function() mc.matchAddCursor(1) end, { desc = 'Add cursor at next match' })
  set({ 'n', 'x' }, 'gN', function() mc.matchAddCursor(-1) end, { desc = 'Add cursor at prev match' })
  set({ 'n', 'x' }, 'ga', mc.matchAllAddCursors, { desc = 'Add cursor at all matches' })

  -- Add cursors above/below
  set({ 'n', 'x' }, '<Up>', function() mc.lineAddCursor(-1) end, { desc = 'Add cursor above' })
  set({ 'n', 'x' }, '<Down>', function() mc.lineAddCursor(1) end, { desc = 'Add cursor below' })

  -- Ctrl+click to add/remove cursors
  set('n', '<C-LeftMouse>', mc.handleMouse, { desc = 'Add/remove cursor (click)' })

  mc.addKeymapLayer(function(layerSet)
    layerSet({ 'n', 'x' }, '<Left>', mc.prevCursor)
    layerSet({ 'n', 'x' }, '<Right>', mc.nextCursor)
    layerSet({ 'n', 'x' }, '<Leader>x', mc.deleteCursor)
    layerSet('n', '<Esc>', function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      else
        mc.clearCursors()
      end
    end)
  end)

  local hl = vim.api.nvim_set_hl
  hl(0, 'MultiCursorCursor', { reverse = true })
  hl(0, 'MultiCursorVisual', { link = 'Visual' })
  hl(0, 'MultiCursorSign', { link = 'SignColumn' })
  hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
  hl(0, 'MultiCursorDisabledCursor', { reverse = true })
  hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
  hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
end)

-- Dang language support ======================================================

-- Tree-sitter grammar, LSP, and filetype detection for the Dang language.
now_if_args(function()
  add({ 'https://github.com/vito/dang.nvim' })
  require('dang').setup()
end)
