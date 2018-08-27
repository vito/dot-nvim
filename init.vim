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
set termguicolors
set background=dark
colorscheme gruvbox

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

" don't insert two spaces after ., ?, or ! when gq'ing
set nojoinspaces

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
autocmd BufEnter * call ncm2#enable_for_buffer()
set cmdheight=2
set completeopt=noinsert,menuone,noselect

" tab for cycling through options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev Ag Ack
endif

" load language-specific configuration
runtime! lang/*.vim

" source local config if any
if !empty(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
end

" don't auto-fold
set foldlevelstart=99

" don't force loclists to the bottom
let g:qf_loclist_window_bottom = 0

" let vim-qf_resize handle resizing, since vim-qf's is broken
let g:qf_auto_resize = 0

" exclude gitignored files from ctrl+p
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
