set completeopt=menu,menuone,noselect,noinsert

lua <<EOF
local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

require("cmp_git").setup()

local preselect = function(entry1, entry2)
  local preselect1 = entry1.completion_item.preselect or false
  local preselect2 = entry2.completion_item.preselect or false
  if preselect1 ~= preselect2 then
    return preselect1
  end
end

local compare = require('cmp.config.compare')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' }
  }),

  experimental = {
    ghost_text = true
  },

  sorting = {
    comparators = {
      preselect,
      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },

  view = {
    entries = {
      name = 'custom',
      selection_order = 'near_cursor'
    },
  },

  -- disable preselection so <CR> is never interrupted; just use <TAB> since
  -- the preselected one will be at the top
  preselect = cmp.PreselectMode.None,

  -- adapted from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
  mapping = {
    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  },
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('markdown', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'emoji' },
  })
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
EOF
