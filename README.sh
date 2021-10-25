#!/bin/sh

# step 1
git clone https://github.com/vito/dot-nvim.git ~/.config/nvim

# step 2
vim +PlugInstall

cat <<EOF
cheatsheet:
  normal mode:
    <Enter> - save
    <Space> - reset search highlight

    <C-hjkl> - faster window switching

    ,u - toggle undo tree

    # LSP
    [d - previous diagnostic
    ]d - next diagnostic
    gd - go to definition
    gy - go to definition of value's type
    gi - go to implementations of interface or method
    gr - go to references
    ,rn - rename function/var/etc

    # telescope
    ,ff - fuzzy find file
    ,fg - fuzzy grep across all files
    ,fb - fuzzy switch buffer
    ,fh - fuzzy vim help tags

    # floaterm
    <C-t> - toggle floaterm (assumes fish shell)

    # from gitsigns
    [c  - previous hunk
    ]c  - next hunk
    ,hs - stage hunk
    ,hu - undo stage hunk

    # from vim-test
    ,tn - test nearest
    ,tf - test file
    ,ts - test suite
    ,tl - test last ran
    ,tg - go to the last run test

    # completion (TODO: tweak, it feels awkward)
    <C-n> - next
    <C-n> - previous
    <C-y> - accept selected completion

  insert mode:
    jk - <esc>
    kj - <esc>
EOF
