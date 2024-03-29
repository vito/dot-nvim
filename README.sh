#!/bin/sh

# step 1
git clone https://github.com/vito/dot-nvim.git ~/.config/nvim

# step 2
nvim -es -u plugins.vim -i NONE -c "PlugInstall" -c "qa"

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

    # vgit
    [g  - previous hunk
    ]g  - next hunk
    ,gs - buffer hunk stage
    ,gr - buffer hunk reset
    ,gp - buffer hunk preview
    ,gb - buffer blame preview
    ,gf - buffer diff preview
    ,gh - buffer history preview
    ,gu - buffer reset
    ,gg - buffer gutter blame preview
    ,gl - project hunks preview
    ,gd - project diff preview
    ,gq - project hunks qf
    ,gx - toggle diff preference

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
