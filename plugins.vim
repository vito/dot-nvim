call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'

" avoid loading most things in vscode
if !exists('g:vscode')
  " editor UI
  Plug 'mbbill/undotree'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'iamcco/markdown-preview.nvim'
  Plug 'vito/base16-vim'
  Plug 'norcalli/nvim-colorizer.lua'

  " syntax
  Plug 'stephpy/vim-yaml'
  Plug 'dag/vim-fish'
  Plug 'andys8/vim-elm-syntax'
  Plug 'clojure-vim/clojure.vim'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'PProvost/vim-ps1'
  Plug 'hashivim/vim-terraform'
  Plug 'cespare/vim-toml'
  Plug 'Matt-Deacalion/vim-systemd-syntax'
  Plug 'google/vim-jsonnet'
  Plug 'vito/booklit.vim'
  Plug 'alunny/pegjs-vim'
  Plug 'tmux-plugins/vim-tmux'

  " irrelevant
  Plug 'Olical/vim-enmasse'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'jremmen/vim-ripgrep'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'voldikss/vim-floaterm'
  Plug 'vim-test/vim-test'

  " doesn't work
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim' " dependency
  Plug 'reedes/vim-wordy'

  " redundant
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'ntpeters/vim-better-whitespace'

  " poor man's VSCode Live Share
  Plug 'jbyuki/instant.nvim'
end

call plug#end()
