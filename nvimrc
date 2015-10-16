execute pathogen#infect()
syntax on
filetype plugin indent on

" 2 spaces for tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" escape with jj, as it should be
imap jj <esc>

" save on enter
nmap <cr> :w<cr>

" clear highlights on space
nmap <space> :noh<cr>

" enable line number gutter
set number

" shorthand for window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" sensible long line navigation
nmap j gj
nmap k gk

" place swap files somewhere more sane
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp

" mouse support
set mouse=a

" utility for colorscheme development
function! SyntaxItem()
  return "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

" set statusline=%{SyntaxItem()}

" disable fucking stupid yaml indenting logic
autocmd FileType yaml setlocal indentexpr=

" go setup
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

autocmd FileType go compiler go
autocmd! BufEnter *.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

" autocomplete config
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.go = '[a-zA-Z_\.]'
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" colors
colorscheme jellybeans
let g:jellybeans_use_lowcolor_black = 0

" undo persists across sessions
if has('persistent_undo')
  set undofile
  set undodir=~/.nvim/.undo
endif

" nerdtree bindings
nnoremap \ :NERDTreeToggle<CR>
nnoremap \| :NERDTreeFind<CR>

" source local config if any
if !empty(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
end
