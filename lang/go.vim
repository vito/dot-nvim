autocmd FileType go compiler go
autocmd! BufEnter *.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

" vim-go setup
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 1 " use neomake instead

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

" wire in Neomake
autocmd BufEnter *.go let &makeprg = gomakeprg
autocmd BufEnter *.go let &errorformat = goerrorformat
autocmd! BufWritePost *.go Neomake!
