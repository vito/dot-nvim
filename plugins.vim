call plug#begin(stdpath('data') . '/plugged')

" bare necessities
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'

" existential crises
Plug 'github/copilot.vim'

" editor UI
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ntpeters/vim-better-whitespace'
Plug 'folke/which-key.nvim'
Plug 'RRethy/nvim-treesitter-textsubjects'

" color schemes
Plug 'vito/base16-vim'
Plug 'folke/tokyonight.nvim'
Plug 'rose-pine/neovim'
Plug 'whatyouhide/vim-gotham'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'fcpg/vim-farout'
Plug 'fcpg/vim-orbital'
Plug 'fcpg/vim-fahrenheit'
Plug 'ahmedabdulrahman/aylin.vim'
Plug 'cseelus/vim-colors-tone'
Plug 'yuttie/inkstained-vim'

" syntax
Plug 'fatih/vim-go'
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
Plug 'reedes/vim-wordy'

" svelte syntax
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" utility belt
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'kazhala/close-buffers.nvim'
Plug 'pbrisbin/vim-mkdir'
Plug 'Olical/vim-enmasse'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'voldikss/vim-floaterm'
Plug 'vim-test/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" lsp and friends
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'petertriho/cmp-git'

" source local config if any
if !empty(glob("~/.nvimrc-plugins.local"))
  source ~/.nvimrc-plugins.local
end

call plug#end()
