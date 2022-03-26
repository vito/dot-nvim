" load plugins
runtime! plugins.vim

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
set tabstop=2
set shiftwidth=2
set softtabstop=2

" enable line number gutter
set number

" undo persists across sessions
if has('persistent_undo')
  set undofile
endif

" escape with smashing j and k; easier to press quickly on slow systems
imap jk <esc>
imap kj <esc>

" save on enter
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? '\<CR>' : ':w<CR>'

" keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

" make the cursor easy to find (e.g. with a ton of splits)
"
" note: at one point i disabled this for performance reasons, but maybe it's
" fine now
set cursorline

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

" more intuitive split directions
set splitright
set splitbelow

" don't auto-fold
set foldlevelstart=99

" set a file for spellwords
set spellfile=~/.config/nvim/spell.utf-8.add

" load language-specific configuration
runtime! lang/*.vim

" load color config
runtime! colors.vim

" load plugin-centric config
runtime! ext/*.vim

" source local config if any
if !empty(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
end
