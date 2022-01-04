call plug#begin(stdpath('data') . '/plugged')

" bare necessities
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-obsession'
Plug 'andymass/vim-matchup'

" editor UI
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'nvim-lualine/lualine.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ntpeters/vim-better-whitespace'

" color schemes
Plug 'vito/base16-vim'
Plug 'folke/tokyonight.nvim'
Plug 'rose-pine/neovim'
Plug 'whatyouhide/vim-gotham'

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
Plug 'vito/bass.vim'

" utility belt
Plug 'Olical/vim-enmasse'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'pbrisbin/vim-mkdir'
Plug 'voldikss/vim-floaterm'
Plug 'vim-test/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" lsp and friends
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'petertriho/cmp-git'

" source local config if any
if !empty(glob("~/.nvimrc-plugins.local"))
  source ~/.nvimrc-plugins.local
end

call plug#end()
