execute pathogen#infect()

" NB: these may become default; see https://github.com/neovim/neovim/pull/2675
filetype plugin indent on
syntax enable

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
colorscheme jellybeans
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
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.go = '[a-zA-Z_\.]'

" tab for cycling through options
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" disable fucking stupid yaml indenting logic
autocmd FileType yaml setlocal indentexpr=

" go setup
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" vim-go's extra quickfix is redundant with Neomake on save
let g:go_fmt_fail_silently = 1

" run go test first to catch errors in tests and code, and then gometalinter
let gomakeprg =
  \ 'go test -o /tmp/vim-go-test -c ./%:h && ' .
    \ '! gometalinter ' .
      \ '--disable=gofmt ' .
      \ '--disable=dupl ' .
      \ '--tests ' .
      \ '--fast ' .
      \ '--sort=severity ' .
      \ '--exclude "should have comment" ' .
    \ '| grep "%"'

" match gometalinter + go test output
let goerrorformat =
  \ '%f:%l:%c:%t%*[^:]:\ %m,' .
  \ '%f:%l::%t%*[^:]:\ %m,' .
  \ '%W%f:%l: warning: %m,' .
  \ '%E%f:%l:%c:%m,' .
  \ '%E%f:%l:%m,' .
  \ '%C%\s%\+%m,' .
  \ '%-G#%.%#'

autocmd FileType go compiler go
autocmd! BufEnter *.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd BufEnter *.go let &makeprg = gomakeprg
autocmd BufEnter *.go let &errorformat = goerrorformat

" make on save to show build errors in quickfix
autocmd! BufWritePost *.go Neomake!

" open list automatically but preserve cursor position
let g:neomake_open_list = 2
let g:neomake_list_height = 5

" source local config if any
if !empty(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
end
