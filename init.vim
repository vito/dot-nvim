execute pathogen#infect()

" enable mouse in all modes
set mouse=a

" use comma as leader key
let mapleader=","

" reveal neighbor text when nearing screen borders
set scrolloff=1
set sidescrolloff=5

" always assume bash when executing stuff
set shell=/bin/bash

" 2 spaces for tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" enable line number gutter
set number

" place swap files somewhere more sane
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp

" undo persists across sessions
if has('persistent_undo')
  set undofile
  set undodir=~/.nvim/.undo
endif

" ignore binary files
set wildignore+=*.a

" colors
colorscheme ir_black
let g:jellybeans_use_lowcolor_black = 0

" escape with smashing j and k; easier to press quickly on slow systems
imap jk <esc>
imap kj <esc>

" save on enter
nmap <cr> :w<cr>

" clear highlights on space
nmap <space> :noh<cr>

" shorthand for window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" work around sketchy <C-h> behavior; hopefully this can be removed someday
nmap <BS> <C-w>h

" sensible long line navigation
nmap j gj
nmap k gk

" nerdtree bindings
nnoremap \ :NERDTreeToggle<CR>
nnoremap \| :NERDTreeFind<CR>

" undotree bindings
nnoremap <leader>u :UndotreeToggle<CR>

" utility for colorscheme development
function! SyntaxItem()
  return "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

" set statusline=%{SyntaxItem()}

" autocomplete config
set completeopt+=noselect " deoplete.nvim recommend
set completeopt-=preview
set cmdheight=2
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" tab for cycling through options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" open list automatically but preserve cursor position
let g:neomake_open_list = 2
let g:neomake_list_height = 5

" use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

" load language-specific configuration
runtime! lang/*.vim

" source local config if any
if !empty(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
end

" don't auto-fold
set foldlevelstart=99
